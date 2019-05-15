Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47FC91F82D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 18:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfEOQIl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 12:08:41 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43265 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfEOQIl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 12:08:41 -0400
Received: by mail-qk1-f194.google.com with SMTP id z6so298502qkl.10;
        Wed, 15 May 2019 09:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rDzDXjuWrp9NigrMtjTMJdSWxU9Nebxe8lEb+hdgCeM=;
        b=VHn9zykAWaopBAUtLYpZi2AwAslx4LYXUZC6gIWm3y3oTwtX1uqctoyNvZdojuOpa2
         vGA20hlW+frZp52TTjJKD9a3KSfubK9jQGL/jOGj5EswmKpBa4bimDk8B25CApqyoT5P
         Nloc1fl83rg5n0HzsjceJf9wFDSOJmkoLRsdp5v7AxQGhFBO+t34gBdvgXXEIuxoetZe
         UZ5msDMVecVGJqPN6AynIdMkPzlx9U5dcg5tXSGWpK91Hnuj7E5GacEpvXKNcm2mdCa/
         ujzPDsvL4SQRaOSNpzvae2YSNesTKPMELO6xwduxu4zBaW/RwXBTQ3OWrDeRMW8k+7nb
         hQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rDzDXjuWrp9NigrMtjTMJdSWxU9Nebxe8lEb+hdgCeM=;
        b=ot5TBcHfGpioosB7KpPYfZO2EAiCt+/WueNpbnr1NaGO4wsn2N5vrXeaeS1859acrZ
         Ul2w134WAAa+4/Jv3gUplWqp+QEHhBoJ5Egg7/bftJwqUPhHiCEmyXglbczm5ZC+P2rH
         HBbH3gtQJmkVHJv5h2OLGVI8yeLthIcciR13nABFhojI7fa8WC8RrKXCQMkxb++1jhpX
         6nHCqP44yojMsmNHSB3OCrgmUAp4PRiXeO2u/0ZvYxdV7BTlPMuBzcK8KpUygwXIDbjS
         lxIM0Irf6jyxo0Q0CLl4VTFpUav3/WoyrXcjOTti1YInpg3BqnYo2QID9hs5fkDDmRDe
         jPyg==
X-Gm-Message-State: APjAAAWLWL71XOoVJrjh9kNRUXuQ25+3YkPIjtNSdfzhLOU9C/UWuD8j
        kXN9HjjLk25i1UpYbly7HcQ=
X-Google-Smtp-Source: APXvYqzBSgmaU+b+dESWX3eMqn5yo+6EymAdXwgwSwLiqCxivmGIgjG1gsocO/0wUT7h94ZAaOefcA==
X-Received: by 2002:a37:6c84:: with SMTP id h126mr35184313qkc.168.1557936519219;
        Wed, 15 May 2019 09:08:39 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o24sm1249308qtp.94.2019.05.15.09.08.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 09:08:38 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 15 May 2019 12:08:36 -0400
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Rob Landley <rob@landley.net>,
        Andy Lutomirski <luto@kernel.org>,
        Arvind Sankar <niveditas98@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        initramfs@vger.kernel.org,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
Message-ID: <20190515160834.GA81614@rani.riverdale.lan>
References: <20190512194322.GA71658@rani.riverdale.lan>
 <3fe0e74b-19ca-6081-3afe-e05921b1bfe6@huawei.com>
 <4f522e28-29c8-5930-5d90-e0086b503613@landley.net>
 <f7bc547c-61f4-1a17-735c-7e8df97d7965@huawei.com>
 <CALCETrV3b205L38xqPr6QqwGn6-vxQdPoJGUygJJpgM-JqqXfQ@mail.gmail.com>
 <1557861511.3378.19.camel@HansenPartnership.com>
 <4da3dbda-bb76-5d71-d5c5-c03d98350ab0@landley.net>
 <1557878052.2873.6.camel@HansenPartnership.com>
 <20190515005221.GB88615@rani.riverdale.lan>
 <a138af12-d983-453e-f0b2-661a80b7e837@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a138af12-d983-453e-f0b2-661a80b7e837@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 15, 2019 at 01:19:04PM +0200, Roberto Sassu wrote:
> On 5/15/2019 2:52 AM, Arvind Sankar wrote:
> > You can specify multiple initrd's to the boot loader, and they get
> > loaded in sequence into memory and parsed by the kernel before /init is
> > launched. Currently I believe later ones will overwrite the earlier
> > ones, which is why we've been talking about adding an option to prevent
> > that. You don't have to mess with manually finding/parsing initramfs's
> > which wouldn't even be feasible since you may not have the drivers
> > loaded yet to access the device/filesystem on which they live.
> > 
> > Once that's done, the embedded /init is just going to do in userspace
> > wht the current patch does in the kernel. So all the files in the
> > external initramfs(es) would need to have IMA signatures via the special
> > xattr file.
> 
> So, the scheme you are proposing is not equivalent: using the distro key
> to verify signatures, compared to adding a new user key to verify the
> initramfs he builds. Why would it be necessary for the user to share
> responsibility with the distro, if the only files he uses come from the
> distro?
> 
I don't understand what you mean? The IMA hashes are signed by some key,
but I don't see how what that key is needs to be different between the
two proposals. If the only files used are from the distro, in my scheme
as well you can use the signatures and key provided by the distro. If
they're not, then in your scheme as well you would have to allow for a
local signing key to be used. Both schemes are using the same
.xattr-list file, no?

If the external initramfs is to be signed, and it is built locally, in
both schemes there will have to be a provision for a local signing key,
but this key in any case is verified by the bootloader so there can't
be a difference between the two schemes since they're the same there.

What is the difference you're seeing here?
> 
> > Note that if you want the flexibility to be able to load one or both of
> > two external initramfs's, the current in-kernel proposal wouldn't be
> > enough -- the xattr specification would have to be more flexible (eg
> > reading .xattr-list* to allow each initramfs to specifiy its own
> > xattrs. This sort of enhancement would be much easier to handle with the
> > userspace variant.
> 
> Yes, the alternative solution is to parse .xattr-list at the time it is
> extracted. The .xattr-list of each initramfs will be processed. Also,
> the CPIO parser doesn't have to reopen the file after all other files
> have been extracted.
> 
> Roberto
Right, I guess this would be sort of the minimal "modification" to the
CPIO format to allow it to support xattrs.
> 
> -- 
> HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
> Managing Director: Bo PENG, Jian LI, Yanli SHI
