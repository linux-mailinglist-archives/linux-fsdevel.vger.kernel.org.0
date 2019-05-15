Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74D9F1E606
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 02:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfEOA0A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 20:26:00 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44890 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfEOA0A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 20:26:00 -0400
Received: by mail-qt1-f194.google.com with SMTP id f24so1265195qtk.11;
        Tue, 14 May 2019 17:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xbEZhhiTM5wPNpwedpHvuoXmY8IRI4IkCvFgEMZLO20=;
        b=n8yIZHnglVsiT8HXDCM669WIA0nw/n9iXppL/q3GzyAOYP9Y4q7SzKD4rxVRcCTqcJ
         CZK+uGoT1Dt2X04VI/OkFE1HiFZUVbrQDK7lZBrx7SZ0kG6FfxdH5SYNqBEu7/LCVAg5
         +wnmct38kudlNt8EOeaiJB1ihdceeI5u5UKfjcdTjKr7WjAVWrhjfgGpDkBoEDPlPNxP
         nN3hCl5OPu60Nm1KkdBCo5oIw9KNmw5juEsTFnZjLRfWoAYOO+Cqjeg0DvN6J8Sdzruc
         CeSKNPwMYtjTsDMu73uP2YdKS5s+gjziyao3h2D+c3MenoM8YaQuJdHIJizEMifYAvq3
         qTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xbEZhhiTM5wPNpwedpHvuoXmY8IRI4IkCvFgEMZLO20=;
        b=qZAP8MEJPmsS/NVsnB10MnLhzBVLCXJi0o+6ArdtsmFMKnMlMkVPtpchJ12pilaQTX
         A5wiuTADWdBNWKp4ZECy2BsF82l3K31yabBwSKxCg34AubcUuXV79qw4sF1X1cjwsAL/
         cb9lRI45+RTdoJcCMCdi6x9QoPMJAedLInYOYOPsfTX0WtMJF7Nd+ersbHRoLMWRPfTf
         da5kJHNqrcarMUQFzLZVHhrKa7t8xbYg5HllnetbqDygC2cp1+rA5XxbRfJEZ1Phtl4t
         3LVrJoNeO0BP9Q23NZ///Meufg2WFSX5ApKnnR/XYjcUNErId0HRuwv8ZDFddoiFJP0a
         fmKg==
X-Gm-Message-State: APjAAAVJ9H1QjgjI48E5gSsIvm3UzyWu2wrmi839ism419vu4KKytWnm
        ixk6g8NiUojVbSVErmkLMKs=
X-Google-Smtp-Source: APXvYqzzMKfeoolE+f8xhkxIlnOD6q5hGrnd1zKle3OBintg9n870NCYQHDt8rsg0U/hV9MGZgUljQ==
X-Received: by 2002:ac8:34b7:: with SMTP id w52mr32652097qtb.11.1557879959377;
        Tue, 14 May 2019 17:25:59 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id l12sm398385qta.82.2019.05.14.17.25.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 17:25:58 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 14 May 2019 20:25:57 -0400
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Rob Landley <rob@landley.net>,
        Arvind Sankar <niveditas98@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        initramfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
Message-ID: <20190515002556.GA88615@rani.riverdale.lan>
References: <dca50ee1-62d8-2256-6fdb-9a786e6cea5a@landley.net>
 <20190512194322.GA71658@rani.riverdale.lan>
 <3fe0e74b-19ca-6081-3afe-e05921b1bfe6@huawei.com>
 <4f522e28-29c8-5930-5d90-e0086b503613@landley.net>
 <f7bc547c-61f4-1a17-735c-7e8df97d7965@huawei.com>
 <CALCETrV3b205L38xqPr6QqwGn6-vxQdPoJGUygJJpgM-JqqXfQ@mail.gmail.com>
 <9357cb32-3803-2a7e-4949-f9e4554c1ee9@huawei.com>
 <20190514165842.GC28266@kroah.com>
 <f01ad775-54de-033f-d8cb-f27f36e92f0c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f01ad775-54de-033f-d8cb-f27f36e92f0c@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 14, 2019 at 07:20:15PM +0200, Roberto Sassu wrote:
> On 5/14/2019 6:58 PM, Greg KH wrote:
> > On Tue, May 14, 2019 at 06:33:29PM +0200, Roberto Sassu wrote:
> >> Right, the measurement/signature verification of the kernel image is
> >> sufficient.
> >>
> >> Now, assuming that we defer the IMA initialization until /init in the
> >> embedded initramfs has been executed, the problem is how to handle
> >> processes launched with the user mode helper or files directly read by
> >> the kernel (if it can happen before /init is executed). If IMA is not
> >> yet enabled, these operations will be performed without measurement and
> >> signature verification.
> > 
> > If you really care about this, don't launch any user mode helper
> > programs (hint, you have the kernel option to control this and funnel
> > everything into one, or no, binaries).  And don't allow the kernel to
> > read any files either, again, you have control over this.
> > 
> > Or start IMA earlier if you need/want/care about this.
> 
> Yes, this is how it works now. It couldn't start earlier than
> late_initcall, as it has to wait until the TPM driver is initialized.
> 
> Anyway, it is enabled at the time /init is executed. And this would be
> an issue because launching /init and reading xattrs from /.xattr-list
> would be denied (the signature is missing).
> 
> And /.xattr-list won't have a signature, if initramfs is generated
> locally.
> 
> Roberto
> 
> -- 
> HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
> Managing Director: Bo PENG, Jian LI, Yanli SHI

The uevent and firmware loader user mode helpers are both obsolete I
believe, so those shouldn't be an issue.

There is still the internal firmware loader (CONFIG_FW_LOADER). If this
is built-in, there's probably no way to 100% stop it racing with /init if we
depend on an embedded /init and a malicious external initramfs image
contains /lib/firmware, but it can be built as an external module, in
which case there should be no danger until the boot process actually loads it.
