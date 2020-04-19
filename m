Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7191AFEEE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 01:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgDSXkv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 19:40:51 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45731 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgDSXkv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 19:40:51 -0400
Received: by mail-pg1-f196.google.com with SMTP id w11so4134746pga.12;
        Sun, 19 Apr 2020 16:40:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3pB9t58pK0EznN9S4Sd0+htiX+z00NIIdr4sNq8MWCA=;
        b=eQaEenyGHp/rkbaX5tp/zQ3kyEOEYl5wiyWsiESCVhGVeJZVy8ukOEYFW2SXJochg3
         9kis/JAS7Uuf7XemKlrqltk8ldLVcoGaPuVOUfl6en5fv0UT4wFFWeR28/nMOVNpO8ak
         orjU1A/ex3EKCh9SY+b9IXyj/PZCp4sTAY4ka8gl1ErY3HXJP+UJCP2sX/8nQai9Qzbe
         foHt616t4LQZYlqhBlcXKQJgO8xjyhRuSMJB05iOnU0+icPhOajKNxhHpoI8M/hfQdoV
         KUMmr+arEG/IwOUzkWlU3UfjYLMhyNITVdfpBOIheg+jqn58H352oC+Va1trkHR9Gqzt
         OxOg==
X-Gm-Message-State: AGi0PuY7UAUtycrzt4XJ7FYnDvpd949Jm6uyC7mGRyCrcfLf40Hitgm/
        rmuKjuiLjDnSjr0XihJ8Po567rhL0WU=
X-Google-Smtp-Source: APiQypL0M8AzubBb/6HiLPC5OQyscP2rx0fUGaKDKO6l3uGUZ9dFwn1hO/YwT+koWYrl57dC2MDzaA==
X-Received: by 2002:aa7:8d81:: with SMTP id i1mr14698377pfr.34.1587339649205;
        Sun, 19 Apr 2020 16:40:49 -0700 (PDT)
Received: from [100.124.11.78] ([104.129.198.54])
        by smtp.gmail.com with ESMTPSA id o21sm11906838pjr.37.2020.04.19.16.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2020 16:40:48 -0700 (PDT)
Subject: Re: [PATCH v2 10/10] block: put_device() if device_add() fails
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20200419194529.4872-1-mcgrof@kernel.org>
 <20200419194529.4872-11-mcgrof@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <85a18bcf-4bd0-a529-6c3c-46fcd23a350e@acm.org>
Date:   Sun, 19 Apr 2020 16:40:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200419194529.4872-11-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/19/20 12:45 PM, Luis Chamberlain wrote:
> Through code inspection I've found that we don't put_device() if
> device_add() fails, and this must be done to decrement its refcount.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
