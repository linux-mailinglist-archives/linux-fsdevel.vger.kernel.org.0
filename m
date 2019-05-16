Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEE71FECB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 07:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbfEPF3k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 01:29:40 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37772 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfEPF3j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 01:29:39 -0400
Received: by mail-qt1-f196.google.com with SMTP id o7so2524146qtp.4;
        Wed, 15 May 2019 22:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zPhYJs6tUAai5DYwqxdzu4CT68FsA8mRHrqOPfi0tng=;
        b=BwK3/SkNEbeGhGHCPGal9aJRSkD0A6WMfMZmrfxhorPWHZIuGfJ6oXMKbK0kb0zvVU
         D27Njyax//0BOR7gwqhtcKZ2m76gvtEX6jxGBXtl9Mi/SuXebH0yAIX5Xd56M6zT3y1V
         d9pn2SGP+LtldqLQtL1HtwP4BkzySpUJ/v+Ol4j2OxL4D/T4YVY5tGr/RWp/FbICHKdp
         3Ud3DnOgarX7XpiOupCX76X8+pqlz0F3cRSZKIsSurjzBk1/+XQysRfe+RYCkrPW2ceD
         rHiMz1UTvypR3++jK+jbvF9RIC10pz7L4+EkjOFhpyWyBIR6OycxO9zDcvRjksngMXxw
         E81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zPhYJs6tUAai5DYwqxdzu4CT68FsA8mRHrqOPfi0tng=;
        b=cHTmP8vdZ/gJRtR8sP+sdhXeBXKbL2scyeZqsP8bOXTWQNRxfs6tOyaWt/yNDDvJQr
         o4OWFsbrpGgVmGMpqEJG/etANjyUPwqhIQG9vORZXsRNdHpQwbOrpU77Sk9kfykqV2X3
         ZRGE29GQw7bCIjPODeCSLzCzrRJB2IPvmCXd4sJPGVLfRuKH+fU7pdU0xlzui3r6btGB
         CStche/duJuTPdXCZTpR+/3HDdYdJdtH0VQmlNV3CISeHL81djkDXx0EaMSf2RoGZKge
         0XvEQ7uogzv6gK812gc41/NHNGW6xJ23zIMQIbd6hdWLusFK68aA/WtbI0p7Tv5iEioq
         6Osw==
X-Gm-Message-State: APjAAAX++K/GKJU3jkFBcWql2iYiL1Mh2HZ4Iv0YpkTQJX5xppTxlB20
        woRH6nNVfzfk5b7yVMrYK+iGYtxMqqM=
X-Google-Smtp-Source: APXvYqxV9mBmwmYVkzFISxUjwBj5hupH87klIJjbMyAvtWYLe6nRJtk/xKH4tyjuK03pUxI+QGiQjg==
X-Received: by 2002:ac8:fdd:: with SMTP id f29mr40426005qtk.17.1557984577991;
        Wed, 15 May 2019 22:29:37 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id d64sm2120328qke.55.2019.05.15.22.29.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 22:29:37 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 16 May 2019 01:29:35 -0400
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
Message-ID: <20190516052934.GA68777@rani.riverdale.lan>
References: <4f522e28-29c8-5930-5d90-e0086b503613@landley.net>
 <f7bc547c-61f4-1a17-735c-7e8df97d7965@huawei.com>
 <CALCETrV3b205L38xqPr6QqwGn6-vxQdPoJGUygJJpgM-JqqXfQ@mail.gmail.com>
 <1557861511.3378.19.camel@HansenPartnership.com>
 <4da3dbda-bb76-5d71-d5c5-c03d98350ab0@landley.net>
 <1557878052.2873.6.camel@HansenPartnership.com>
 <20190515005221.GB88615@rani.riverdale.lan>
 <a138af12-d983-453e-f0b2-661a80b7e837@huawei.com>
 <20190515160834.GA81614@rani.riverdale.lan>
 <ce65240a-4df6-8ebc-8360-c01451e724f0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ce65240a-4df6-8ebc-8360-c01451e724f0@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 15, 2019 at 07:06:52PM +0200, Roberto Sassu wrote:
> On 5/15/2019 6:08 PM, Arvind Sankar wrote:
> > On Wed, May 15, 2019 at 01:19:04PM +0200, Roberto Sassu wrote:
> >> On 5/15/2019 2:52 AM, Arvind Sankar wrote:
> > I don't understand what you mean? The IMA hashes are signed by some key,
> > but I don't see how what that key is needs to be different between the
> > two proposals. If the only files used are from the distro, in my scheme
> > as well you can use the signatures and key provided by the distro. If
> > they're not, then in your scheme as well you would have to allow for a
> > local signing key to be used. Both schemes are using the same
> > .xattr-list file, no?
> 
> I was referring to James's proposal to load an external initramfs from
> the embedded initramfs. If the embedded initramfs opens the external
> initramfs when IMA is enabled, the external initramfs needs to be
> signed with a local signing key. But I read your answer that this
> wouldn't be feasible. You have to specify all initramfs in the boot
> loader configuration.
> 
> I think deferring IMA initialization is not the safest approach, as it
> cannot be guaranteed for all possible scenarios that there won't be any
> file read before /init is executed.
> 
> But if IMA is enabled, there is the problem of who signs .xattr-list.
> There should be a local signing key that it is not necessary if the user
> only accesses distro files.
> 
I think that's a separate issue. If you want to allow people to be able
to put files onto the system that will be IMA verified, they need to
have some way to locally sign them whether it's inside an initramfs or
on a real root filesystem.
> 
> > Right, I guess this would be sort of the minimal "modification" to the
> > CPIO format to allow it to support xattrs.
> 
> I would try to do it without modification of the CPIO format. However,
> at the time .xattr-list is parsed (in do_copy() before .xattr-list is
> closed), it is not guaranteed that all files are extracted. These must
> be created before xattrs are added, but the file type must be correct,
> otherwise clean_path() removes the existing file with xattrs.
> 
> Roberto
> 
> -- 
> HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
> Managing Director: Bo PENG, Jian LI, Yanli SHI

Right by "modification" in quotes I meant the format is actually the
same, but the kernel now interprets it a bit differently.

Regarding the order you don't have to handle that in the kernel. The
kernel CPIO format is already restricted in that directories have to be
specified before the files that contain them for example. It can very
well be restricted so that an .xattr-list can only specify xattrs for
files that were already extracted, else you bail out with an error. The
archive creation tooling can easily handle that. If someone wants to
shoot themselves in the foot by trying to add more files/replace
existing files after the .xattr-list its ok, the IMA policy will prevent
such files from being accessed and they can fix the archive for the next
boot.
