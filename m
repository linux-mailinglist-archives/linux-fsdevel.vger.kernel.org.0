Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217FF1AFE4A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 23:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgDSVG2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 17:06:28 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:52318 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgDSVG1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 17:06:27 -0400
Received: by mail-pj1-f66.google.com with SMTP id ng8so3646766pjb.2;
        Sun, 19 Apr 2020 14:06:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3vDmbp1+PZxXf563uiTMcQIb8UZnQcQngCnrvzYbYcs=;
        b=G5RvBth67OZLldbxpYUAD6MYHqAijTaFdf+U/5nJBPDHZCfC8cwKhH3Ui6G3svbrMH
         9y/1fk3V4FY3iZb7djZ5H+BKEsmsLozu/+c0rExBnI7ZjUgpadhGNzrLcOtrtI5W7Tia
         Aj/Joar3eo9CyPTlMCn6MTEcsqQmdiuvWbUdgYHy8q9EoRMpPm2vDjtEHdwcAkqBNFEj
         XyMiQV1lut2AXOU2h1aD8j2EUzAazJgJrEBFIenqBum6rXlg+NaG6BB2HWM7ay+WaNha
         lzteFwPKm14PEBxVc4CH4zctOFnjiYlPks0whyCEbgde3Z6Ju2VqVAnru+Ja6Uz51/NA
         5mYQ==
X-Gm-Message-State: AGi0Pua6Y2BUJ39nQv5P9ZushKH/QmDJNlBIL0AxLVc8See4sK6qxBg3
        uGT5lycZmHCWR3KWjTGUIpg=
X-Google-Smtp-Source: APiQypKwJRdVf5cy9asI9oImq/zCCB2rcM63JFOccHnrrUFWGvh8plEXHEUKCSGnBfsHJvdQeCYePw==
X-Received: by 2002:a17:90a:1b26:: with SMTP id q35mr18374454pjq.149.1587330386845;
        Sun, 19 Apr 2020 14:06:26 -0700 (PDT)
Received: from [100.124.11.78] ([104.129.198.66])
        by smtp.gmail.com with ESMTPSA id x10sm9228352pgq.79.2020.04.19.14.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2020 14:06:26 -0700 (PDT)
Subject: Re: [PATCH v2 01/10] block: move main block debugfs initialization to
 its own file
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
References: <20200419194529.4872-1-mcgrof@kernel.org>
 <20200419194529.4872-2-mcgrof@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <eab0ce38-6285-733b-655d-69451e6aa8ac@acm.org>
Date:   Sun, 19 Apr 2020 14:06:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200419194529.4872-2-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/19/20 12:45 PM, Luis Chamberlain wrote:
> make_request-based drivers and and request-based drivers share some
> some debugfs code. By moving this into its own file it makes it easier
> to expand and audit this shared code.

If this patch is reposted, please change "some some" into "some".

Thanks,

Bart.
