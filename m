Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A946EE40E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 03:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388546AbfJYBPt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 21:15:49 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40815 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388531AbfJYBPt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 21:15:49 -0400
Received: by mail-ed1-f67.google.com with SMTP id p59so499632edp.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 18:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H1GaUvponGzx8dfabBhKW2OqVVQdC3N0IbNOHN+GfyA=;
        b=F7CvUN1nPbeQ3ofUpTfw3ik8aSK5aNiLPnsPsnj56b2FzDgopyq8dS+4OdywSY3cRK
         Eb7pBK79RZCAqa7dMaDNiALdZ1Q3F4Qp1fNImEMnjWIyz47c4BHaKK+WCMwcPVNBfHiN
         xknjfj8h/cTsqLjN1CpurQu9NYku85BMGiwf+6d9S5cE50PlssibV/Qo7E4k6g+D1o7G
         BXtMdHwxSZDmgNJWJzqGOPCg0ZODwFjbIvuczE7ACnosAFZZhRB0n7cefeG6+aipnjAf
         ijbC86raCT7G6EcIKb+iSX/posRmH1Oq7/anIPBl3mwLVo+v+cMt72aXJqlVakb/ePHY
         pyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H1GaUvponGzx8dfabBhKW2OqVVQdC3N0IbNOHN+GfyA=;
        b=rGkGU0DMr2/Bl0tSxNUlqXru9V5QNM6hz87A5gWa95axYwSez7gbz2t4CvX+6QbVL+
         1B80tQsWpuZZ7mXp/7e1rIzbZcpl1Q1HsDQGMSXMwuDPuVrm0FOLMNQ6/uAgA6Azy9rg
         fulNKzGgmBOgtx4E3LCsQ2b4YlgYyskLVKinWvDH844u30LYkt2c4CLu0dDvq3pbSWkd
         hlPlSoNzr+QCfVod1C3F+CfBxFYkFvA1cTU9ut1fTdgMzqloeS1F2vAERLIdvJcbI+wO
         /J361QTicol5CI5QH6adehnwpsYioOYO4VYZRQbbagHod3EZPqXtEKJwt+wtrNvAJaSB
         0cvw==
X-Gm-Message-State: APjAAAXJua2YfThj0Y4aPfSG++qmyYzWpRmWDYB6QeVQNDNKvexazKLE
        0AF7qWMiXO92urUXZoUl1AZxZzWax58=
X-Google-Smtp-Source: APXvYqz6czjRAMv/BeSl0ugHesI8gzA5oRUMvzQQRtKwlS9OjlmuA9FEFIHOOZH28oxILnBJQbs9HQ==
X-Received: by 2002:a50:cbc2:: with SMTP id l2mr1201839edi.304.1571966147286;
        Thu, 24 Oct 2019 18:15:47 -0700 (PDT)
Received: from [10.68.217.182] ([217.70.210.43])
        by smtp.googlemail.com with ESMTPSA id gj14sm1695ejb.62.2019.10.24.18.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2019 18:15:46 -0700 (PDT)
Subject: Re: [PATCH 0/5] Enable per-file/directory DAX operations
To:     Dave Chinner <david@fromorbit.com>,
        Boaz Harrosh <boaz@plexistor.com>
Cc:     ira.weiny@intel.com, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20191020155935.12297-1-ira.weiny@intel.com>
 <b7849297-e4a4-aaec-9a64-2b481663588b@plexistor.com>
 <b883142c-ecfe-3c5b-bcd9-ebe4ff28d852@plexistor.com>
 <20191023221332.GE2044@dread.disaster.area>
 <efffc9e7-8948-a117-dc7f-e394e50606ab@plexistor.com>
 <20191024073446.GA4614@dread.disaster.area>
 <fb4f8be7-bca6-733a-7f16-ced6557f7108@plexistor.com>
 <20191024213508.GB4614@dread.disaster.area>
 <ab101f90-6ec1-7527-1859-5f6309640cfa@plexistor.com>
 <20191025003603.GE4614@dread.disaster.area>
From:   Boaz Harrosh <boaz@plexistor.com>
Message-ID: <9ffbc2a5-c85b-3633-1ad5-a9a3fe33cd2e@plexistor.com>
Date:   Fri, 25 Oct 2019 04:15:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191025003603.GE4614@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 25/10/2019 03:36, Dave Chinner wrote:
> On Fri, Oct 25, 2019 at 02:29:04AM +0300, Boaz Harrosh wrote:
<>

>> Perhaps we always go by the directory. And then do an mv dir_DAX/foo dir_NODAX/foo
> 
> The inode is instatiated before the rename is run, so it's set up
> with it's old dir config, not the new one. So this ends up with the
> same problem of haivng to change the S_DAX flag and aops vector
> dynamically on rename. Same problem, not a solution.
> 

Yes Admin needs a inode-drop_caches after the mv if she/he wants an effective
change.

>> to have an effective change. In hard links the first one at iget time before populating
>> the inode cache takes affect.
> 
> If something like a find or backup program brings the inode into
> cache, the app may not even get the behaviour it wants, and it can't
> change it until the inode is evicted from cache, which may be never.

inode-drop-caches. (echo 2 > /proc/sys/vm/drop_caches)

> Nobody wants implicit/random/uncontrollable/unchangeable behaviour
> like this.
> 

You mean in the case of hard links between different mode directories?
I agree it is not so good. I do not like it too.

<>
> We went over all this ground when we disabled the flag in the first
> place. We disabled the flag because we couldn't come up with a sane
> way to flip the ops vector short of tracking the number of aops
> calls in progress at any given time. i.e. reference counting the
> aops structure, but that's hard to do with a const ops structure,
> and so it got disabled rather than allowing users to crash
> kernels....
> 

Do you mean dropping this patchset all together? I missed that.

Current patchset with the i_size == 0 thing is really bad I think.
Its the same has dropping the direct change all together and only
supporting inheritance from parent.
[Which again for me is really not interesting]

> Cheers,
> -Dave.

Lets sleep on it. Please remind me if xfs supports clone + DAX

Thanks Dave
Boaz
