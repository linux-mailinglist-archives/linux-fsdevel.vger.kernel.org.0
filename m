Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58DA92202A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2019 00:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbfEQWRg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 18:17:36 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34098 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfEQWRg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 18:17:36 -0400
Received: by mail-qt1-f193.google.com with SMTP id h1so9871005qtp.1;
        Fri, 17 May 2019 15:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4Hl8T+4u/qgIIk8+r4CsaXe+ilR4CzdKuLNrb4mEdnE=;
        b=NV6J2lErU6kauPc1kdxYtPdNeGXhZZheMQ4RIrEQR9uGKQuH4FGDCUqL7wyIsbrmL2
         SedIMzzQajeBX/kOSToUXNSVRlHY+qB+iRxAX/xrtGX3IVXJ/tiLfTLLQc0ntNtLp4r4
         ktTQGzGO/15ZcxMbT24qyow8ZDxjcsIlQz2VrMiMeoWdyMQRzOx7VmKPMnNCuCjVYzkN
         J//i5uYN7StnsOKqjoJU7u7vIpdBvwsq7bLS6C+9uvNwR9aV1Q4ZjzIi51gFdUtlj6eu
         cXO/vRglGr6Gl0rW1pE2aKVtQ8lXDvszVctfM2YwH1ZmsQ8/hsL0MfFatbfnP1SEFdrG
         uHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4Hl8T+4u/qgIIk8+r4CsaXe+ilR4CzdKuLNrb4mEdnE=;
        b=OdklydhNB/+vzQslkY3Jf0TSZ8MJ/aawk5df0E+o4LY5JCy2C9D8Scaf/oS/B26y5q
         CN4T3yrp5plwDepkNHVpaiXVM/SxcwK8u7vzowLkWNPWMzIFPI6P+uruUlIduNfmVAWL
         ReSorAVk6fVHvMykzCNxtugmcl7CmfNeKV8VYkhRkfnWW2KUfn/XmmFyjN+z9MpnHzcA
         8HXFoxSu+PGaAjCO9VOlCDo7kFCBGmDxOjY4GwmYujQs5iO7D+kFerhz9UssqAV/HWBk
         wSquE+R6+mv8tMq5HXQOhyX58KFzd3nqd6mT7tpV7R1Mq71PpVdaxzSXaJ1ywC6GyWwF
         uRHA==
X-Gm-Message-State: APjAAAUDJsQSPcbqXfo0Gup6IyC9zEmI4CPQwa10+e5xq2+w/0T6os6W
        Va5avxB9goEROwoMl0MKRVg=
X-Google-Smtp-Source: APXvYqxxUYDge47vddAWXjHSnKIL8D9j1YJySwbTD27V4UaA7kVHiSbNMOKcE9PfZBtm16oIHqUGXQ==
X-Received: by 2002:ac8:32d1:: with SMTP id a17mr43459703qtb.111.1558131454998;
        Fri, 17 May 2019 15:17:34 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id c16sm5405296qkb.15.2019.05.17.15.17.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 15:17:34 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 17 May 2019 18:17:32 -0400
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        viro@zeniv.linux.org.uk, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, initramfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.vnet.ibm.com,
        silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com,
        takondra@cisco.com, kamensky@cisco.com, arnd@arndb.de,
        rob@landley.net, james.w.mcmechan@gmail.com, niveditas98@gmail.com
Subject: Re: [PATCH v3 2/2] initramfs: introduce do_readxattrs()
Message-ID: <20190517221731.GA11358@rani.riverdale.lan>
References: <20190517165519.11507-1-roberto.sassu@huawei.com>
 <20190517165519.11507-3-roberto.sassu@huawei.com>
 <CD9A4F89-7CA5-4329-A06A-F8DEB87905A5@zytor.com>
 <20190517210219.GA5998@rani.riverdale.lan>
 <d48f35a1-aab1-2f20-2e91-5e81a84b107f@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d48f35a1-aab1-2f20-2e91-5e81a84b107f@zytor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 17, 2019 at 02:47:31PM -0700, H. Peter Anvin wrote:
> On 5/17/19 2:02 PM, Arvind Sankar wrote:
> > On Fri, May 17, 2019 at 01:18:11PM -0700, hpa@zytor.com wrote:
> >>
> >> Ok... I just realized this does not work for a modular initramfs, composed at load time from multiple files, which is a very real problem. Should be easy enough to deal with: instead of one large file, use one companion file per source file, perhaps something like filename..xattrs (suggesting double dots to make it less likely to conflict with a "real" file.) No leading dot, as it makes it more likely that archivers will sort them before the file proper.
> > This version of the patch was changed from the previous one exactly to deal with this case --
> > it allows for the bootloader to load multiple initramfs archives, each
> > with its own .xattr-list file, and to have that work properly.
> > Could you elaborate on the issue that you see?
> > 
> 
> Well, for one thing, how do you define "cpio archive", each with its own
> .xattr-list file? Second, that would seem to depend on the ordering, no,
> in which case you depend critically on .xattr-list file following the
> files, which most archivers won't do.
> 
> Either way it seems cleaner to have this per file; especially if/as it
> can be done without actually mucking up the format.
> 
> I need to run, but I'll post a more detailed explanation of what I did
> in a little bit.
> 
> 	-hpa
> 
Not sure what you mean by how do I define it? Each cpio archive will
contain its own .xattr-list file with signatures for the files within
it, that was the idea.

You need to review the code more closely I think -- it does not depend
on the .xattr-list file following the files to which it applies.

The code first extracts .xattr-list as though it was a regular file. If
a later dupe shows up (presumably from a second archive, although the
patch will actually allow a second one in the same archive), it will
then process the existing .xattr-list file and apply the attributes
listed within it. It then will proceed to read the second one and
overwrite the first one with it (this is the normal behaviour in the
kernel cpio parser). At the end once all the archives have been
extracted, if there is an .xattr-list file in the rootfs it will be
parsed (it would've been the last one encountered, which hasn't been
parsed yet, just extracted).

Regarding the idea to use the high 16 bits of the mode field in
the header that's another possibility. It would just require additional
support in the program that actually creates the archive though, which
the current patch doesn't.
