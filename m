Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF311AFE50
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 23:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgDSVLh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 17:11:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42021 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgDSVLg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 17:11:36 -0400
Received: by mail-pg1-f194.google.com with SMTP id g6so4015273pgs.9;
        Sun, 19 Apr 2020 14:11:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C7h+slJzaOOCm5ilaZtNlrSSL1NQaxEFbMPqFtrHmfA=;
        b=GADc50Iyy6PcJBKLxMg5AaZM8KQaV3SnvWfNRh/m2hOtuT5FZP+22DtlsQaHtb2+db
         nV8iDSeVfolwfgDEimHDLH3gVl9kU6sytkBj/HgZvZA5WajD4a8AFmIj1kXmTRSE1Y7k
         lRaz6h2nmsxxcv4GUDjTRTgFQn9QObdCyCPXED8J7Hlh5zEBsfQFbfCs1HwzHKFAIOpz
         +fQ9pyqcpjIPFWqRp+0meNCqACL96Zj6pWZi8WshfBpQGC1Gh00857KFkloZqgfX1iVi
         epG3ne6avFvtx1ub10QkvsHasgFHUNL/8ZFXK10088eSn5TCsolHs0zXk91mgIk7r833
         wIMw==
X-Gm-Message-State: AGi0PuagOAi3ed6JXsJ0Y7yMNxNCdUMGOtzzNzF+evdqfrUHcvm98EaL
        rWciWy+eJL22PQsuWyagS2tisJwZX+w=
X-Google-Smtp-Source: APiQypJxk2QSVrkL9cmFour823yUEb2xji+EHimzyAE7WsAoDYVROUkbqxgYFFzOeCB1v34V42DQdg==
X-Received: by 2002:aa7:9a52:: with SMTP id x18mr13547868pfj.139.1587330694432;
        Sun, 19 Apr 2020 14:11:34 -0700 (PDT)
Received: from [100.124.11.78] ([104.129.198.66])
        by smtp.gmail.com with ESMTPSA id k63sm11871301pjb.6.2020.04.19.14.11.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2020 14:11:33 -0700 (PDT)
Subject: Re: [PATCH v2 02/10] blktrace: move blktrace debugfs creation to
 helper function
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20200419194529.4872-1-mcgrof@kernel.org>
 <20200419194529.4872-3-mcgrof@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <beadd64b-cdad-bd6d-ebe1-43b5969c3cf3@acm.org>
Date:   Sun, 19 Apr 2020 14:11:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200419194529.4872-3-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/19/20 12:45 PM, Luis Chamberlain wrote:
> Move the work to create the debugfs directory used into a helper.
> It will make further checks easier to read. This commit introduces
> no functional changes.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

