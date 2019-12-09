Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92A5A117162
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 17:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfLIQUa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 11:20:30 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:32982 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfLIQUa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 11:20:30 -0500
Received: by mail-wm1-f42.google.com with SMTP id y23so259927wma.0;
        Mon, 09 Dec 2019 08:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WBIobri3MkGop/QDs53NXiO6RTUjcrDu0iF/QcG86H0=;
        b=W4rrS4w8J3X0s/knW10xoM7c0XvfkfBWKTpkJv7UBseXclDelL+x9rXP7Toz7IePVV
         E5JzmhHlqkJIHH5mn99dwLDDvtuUF32qwp1jcmmbOYO9Vx9Xa51TZUx2qhVksqgzSF6C
         vkuu8dAlkddPpEADOrxVKmHQ8zrhfZi7ak47Vhg/Xektz7G4ICP9gHMA3onOstOx7DA8
         Gbg3tBaeCRW879E08AF9uT1GP73T9Ro8s3Y5q2RwoPXHxALwKbg8mPZvvVOvtkaY33PM
         /R7quTP54GV5ANZbI5Gh2bNUwoRz/CGy5lW2XqUhfKuy0D60x5FGxD8kfBmIVJPI5Vl9
         3eOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WBIobri3MkGop/QDs53NXiO6RTUjcrDu0iF/QcG86H0=;
        b=hE7kX2P7fDXb+ye04ucoAP12JmDC240Lyt3W7uEqEZw0gI2j9DV+HxLvPxUq+SBGmE
         +cIBDSdO2LeWUMskZymPlzY3vFIvuqIFFjK7ykoHDxukpYwixzxRD8/nYv4iYbC9PfmS
         EnC1S8IXBGAG0n1BqEwSdqpE6vKiRNIVInNl1KaqCzUZppSj8R4wI3B//BDeeHxywXDt
         /FZIkYk0hkSrCKhdXSBu4lmLmcI8nuD6YgLikBhXd8sBcvZpoXdnOgQ4kLnWhFJ0D2zL
         V4IoKpUEk+pjLdgIYrUoagBoGrE8xx1klUWC6wyH1/aBlaozPJ/FX9U5mnWeeMuD8xxt
         TuWw==
X-Gm-Message-State: APjAAAWIzfSkapAplWoamI0mt5orHIfhWDR/mAqNFG3qo8wxrRLh70ks
        ZAwcriJV0cuLcNSNWBgswP0=
X-Google-Smtp-Source: APXvYqyL3Ao5jyCATnxdfctwvZ3CBAbBWb4P4ED0mJcOmAm4L1BkpLHWjA2CTQz7JIP995Or8WFlMA==
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr25766920wmj.96.1575908427479;
        Mon, 09 Dec 2019 08:20:27 -0800 (PST)
Received: from [10.68.217.182] ([217.70.210.43])
        by smtp.gmail.com with ESMTPSA id n10sm27650061wrt.14.2019.12.09.08.20.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 08:20:26 -0800 (PST)
Subject: Re: [Lsf-pc] [LSF/MM TOPIC] The end of the DAX experiment
To:     Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     lsf-pc@lists.linux-foundation.org,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
References: <CAPcyv4jyCDJTpGZB6qVX7_FiaxJfDzWA1cw8dfPjHM2j3j3yqQ@mail.gmail.com>
 <20190214134622.GG4525@dhcp22.suse.cz>
 <CAPcyv4gxFKBQ9eVdn+pNEzBXRfw6Qwfmu21H2i5uj-PyFmRAGQ@mail.gmail.com>
From:   Boaz Harrosh <openosd@gmail.com>
Message-ID: <5a45a763-d060-7cb1-9772-dd6e9f5f868a@gmail.com>
Date:   Mon, 9 Dec 2019 18:20:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4gxFKBQ9eVdn+pNEzBXRfw6Qwfmu21H2i5uj-PyFmRAGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14/02/2019 20:25, Dan Williams wrote:
> On Thu, Feb 14, 2019 at 5:46 AM Michal Hocko <mhocko@kernel.org> wrote:
>>
>> On Wed 06-02-19 13:12:59, Dan Williams wrote:
>> [...]
>>> * Userfaultfd for file-backed mappings and DAX
>>
>> I assume that other topics are meant to be FS track but this one is MM,
>> right?
> 
> Yes, but I think it is the lowest priority of all the noted sub-topics
> in this proposal. The DAX-reflink discussion, where a given
> physical-page may need to be mapped into multiple inodes at different
> offsets, might be more fruitful to have as a joint discussion with MM.
> 

This topic is very interesting to me.
In current ZUFS implementation we support this option for a long time.

IE: Map same pte_t into different indexes of the same file-mappings as well as
in vma(s) of different files, at different indexes. Including invalidation
of mapping of a pwrite into such a shared page.
(A write to a shared block will allocate a new block for writing)

This effort off-course involves the participation of the FileSystem
to give a list of files and indexes for map_unmapping().
I can explain if you want how we did this.

Cheers
Boaz
