Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF4A1E672
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 03:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfEOBAE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 21:00:04 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38370 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfEOBAD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 21:00:03 -0400
Received: by mail-qk1-f196.google.com with SMTP id a64so483108qkg.5;
        Tue, 14 May 2019 18:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ARePknXMvJpXvkpoMG1JARn0M1Qc8PURXSCKZdxSijk=;
        b=QX+LrZZzP+4rPSDGbeSgFAq0eoC1Lo+cmLh4Oq7MYgTx/7p9ppXtdty8AC4ax/fDB3
         jHULiwA5JLFBUXX7ZA3w1zv0McPj6CIZ1bOqxtaJpPKImg4IoVm5fc7/H7Nn8GfMh8Ys
         e6CZRo6DhGufLF3uxJ24gMBfPuqL+BekVOoekmVnStGfcZev9BmBPY/VRR/AlsF+v847
         JijjqOPAjkdCSndncJ8T1JUpQttqXX2jv4usRxSy+ByKnnDCfJT0ECyqrbTAqCh9xdFv
         aGERs20TySYoyaWj2Y6tUPoQiotMlxCC1GvMwMYOloaPqGCAQ9HYZuejFog5QTTH47WW
         XBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ARePknXMvJpXvkpoMG1JARn0M1Qc8PURXSCKZdxSijk=;
        b=MB+tOx8MGNf7ouZUuekaT34KPy1RrZZO64NxpxTM8EKQZxxfCPjs4omHCTkKMBCQnV
         2f3kpjdqGdciGpO8BcEYqcdJurtee3HMWD6F37f+9wxG2hEuBj1mBq2fiw9qf5Dlp8NC
         ijH1AbVrYmwCvB5PSCe4MRRslKcrWIPsGeFOtXaIQudwmnghWsZOBb3j/cpZL87zvLLA
         KZZjjzElwgbKBqoW3iaBCiKX1G8mYn7IPod5mHeJ+GRT3kUn7Y4ZakDGaroN2eVrlssW
         2Wmx9ye2BNjrTUJ1mvsWnzcpEc4DRIigstPyoP4B9ZumIzewt1NtVAE8g17NSDB7j2UX
         qKcg==
X-Gm-Message-State: APjAAAW9fyKdjOJrhY2LQU9qcPWdGprC7jyLmhxXjyTgo7wuKOznMvpc
        qEgq0CtQGNWrhHJhHnqA6aFnQnFOKTg=
X-Google-Smtp-Source: APXvYqxO7/iKCArGqp6drBcdLkZILOYgHxFYMbD6i4ZPSN1nU4yXvrhmAabjBuBag/Zj0WjbRHkabw==
X-Received: by 2002:ae9:f818:: with SMTP id x24mr30059222qkh.329.1557882002597;
        Tue, 14 May 2019 18:00:02 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id f7sm290540qth.41.2019.05.14.18.00.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 18:00:02 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 14 May 2019 21:00:00 -0400
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Rob Landley <rob@landley.net>,
        Arvind Sankar <niveditas98@gmail.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        initramfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
Message-ID: <20190515005959.GC88615@rani.riverdale.lan>
References: <dca50ee1-62d8-2256-6fdb-9a786e6cea5a@landley.net>
 <20190512194322.GA71658@rani.riverdale.lan>
 <3fe0e74b-19ca-6081-3afe-e05921b1bfe6@huawei.com>
 <4f522e28-29c8-5930-5d90-e0086b503613@landley.net>
 <f7bc547c-61f4-1a17-735c-7e8df97d7965@huawei.com>
 <49965ffd-dd57-ffe5-4a2f-73cdfb387848@landley.net>
 <de91ef53-6bb3-b937-8773-5f6b34e1acb7@huawei.com>
 <20190514152704.GB37109@rani.riverdale.lan>
 <20190514155739.GA70223@rani.riverdale.lan>
 <ca622341-5ea2-895e-8b82-7181a709c104@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ca622341-5ea2-895e-8b82-7181a709c104@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 14, 2019 at 07:44:42PM +0200, Roberto Sassu wrote:
> On 5/14/2019 5:57 PM, Arvind Sankar wrote:
> > On Tue, May 14, 2019 at 11:27:04AM -0400, Arvind Sankar wrote:
> >> It's also much easier to change/customize it for the end
> >> system's requirements rather than setting the process in stone by
> >> putting it inside the kernel.
> > 
> > As an example, if you allow unverified external initramfs, it seems to
> > me that it can try to play games that wouldn't be prevented by the
> > in-kernel code: setup /dev in a weird way to try to trick /init, or more
> > easily, replace /init by /bin/sh so you get a shell prompt while only
> > the initramfs is loaded. It's easy to imagine that a system would want
> > to lock itself down to prevent abuses like this.
> 
> Yes, these issues should be addressed. But the purpose of this patch set
> is simply to set xattrs. And existing protection mechanisms can be
> improved later when the basic functionality is there.
> 
Yeah but it's much easier to enhance it when it lives in userspace and
can be tailored to a particular system's requirements. Eg a lot of the
issues will disappear if you don't have to allow for external initramfs
at all, so those systems can have a very simple embedded /init that
doesn't have to do much.
> 
> > So you might already want an embedded initramfs that can be trusted and
> > that can't be overwritten by an external one even outside the
> > security.ima stuff.
> 
> The same problems exist also the root filesystem. These should be solved
> regardless of the filesystem used, for remote attestation and for local
> enforcement.
> 
> -- 
> HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
> Managing Director: Bo PENG, Jian LI, Yanli SHI

