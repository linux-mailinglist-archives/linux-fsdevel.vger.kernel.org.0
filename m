Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFD221CAA8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2019 16:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfENOoL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 10:44:11 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39743 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbfENOoL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 10:44:11 -0400
Received: by mail-qk1-f195.google.com with SMTP id z128so10431156qkb.6;
        Tue, 14 May 2019 07:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MK/EeSYeIjxF8YTDVcELY66892EK1YJmsPeFgAgfrjM=;
        b=qFdfOb2sfefv9BKhBFjgSIS+uytVFyTYQ01SS/qtY0zqykm8VlTLnzSLtzv7QxzVth
         Un7eDsop3VKZJC1EVd6XQpNfWig7m6h2m69LtD0Y5JLiiTr04ZS0LEWa7FjLql/o3qHl
         O7HVDtrCJDu7HTU8+WIMJdMxzEreKcply4xEir4+Pv1PClq2/Gcu6WNG4NDBJuK3VSZa
         2eWFbELeMgW2NQ06TCD4S95CPB0dl3sK1becx5Cf0gM8+0W5lLRqw6P2+vPwbQcqMgl8
         W2lYGRotHkH389BRu9YrUNYuioMiZFGvkiJfKEBfRZBe5j/iZzUTy5QB/vcHsTWMgq5t
         /OrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=MK/EeSYeIjxF8YTDVcELY66892EK1YJmsPeFgAgfrjM=;
        b=n1dehGjbpQoYTxOTZowrc24AuLMmTi8H6Ep3ikekGaApmG/Xw4+9olSaq5Gw9+ce+L
         N9eGG/K+Z0nPr8zdnHOS3eMQhWvZfVfH7crOx4UCvjJxiW51nLHY/9ADRu2Viv8OTasI
         osKofXo3PZZaUgktc98071oeN3Vt1XJhdC+74aLmtXzXczQZFSGdc6eMirGx5ovbdx53
         RnNnu4+688hniVb5Ol5zoAduuyq4ZPE5RzZbQesXGdY+WdNFUdKa55N53uCyOWJLFWo3
         m5CHrf56v+u/gLp/HZxA4aL/Q+jNFQIKnB+6NzXJvSYOtU0ssD7M0/tEb2yd5QaNsQwo
         Ojhg==
X-Gm-Message-State: APjAAAWJpoHgUsfH4tZj0vq6smNBtWroRhITQtp8uAcS64YCAFcz4DqS
        0ksg3EEPsmgOktdOyTC73P4=
X-Google-Smtp-Source: APXvYqyOJRF/R0s6XEjfz+HFqZXUy/U3dE0Nq2kon+YZAEx3Nx+C5qxM5rRFpkNMj/j57uhOGWxe4Q==
X-Received: by 2002:a37:495:: with SMTP id 143mr27573670qke.106.1557845049750;
        Tue, 14 May 2019 07:44:09 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id d64sm5449740qke.55.2019.05.14.07.44.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 07:44:09 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 14 May 2019 10:44:07 -0400
To:     Rob Landley <rob@landley.net>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Arvind Sankar <niveditas98@gmail.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        initramfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
Message-ID: <20190514144406.GA37109@rani.riverdale.lan>
References: <20190512194322.GA71658@rani.riverdale.lan>
 <3fe0e74b-19ca-6081-3afe-e05921b1bfe6@huawei.com>
 <4f522e28-29c8-5930-5d90-e0086b503613@landley.net>
 <f7bc547c-61f4-1a17-735c-7e8df97d7965@huawei.com>
 <20190513172007.GA69717@rani.riverdale.lan>
 <20190513175250.GC69717@rani.riverdale.lan>
 <1557772584.4969.62.camel@linux.ibm.com>
 <20190513184744.GA12386@rani.riverdale.lan>
 <1557785351.4969.94.camel@linux.ibm.com>
 <66b57ae5-bb5a-c008-8490-2c90e050fc65@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66b57ae5-bb5a-c008-8490-2c90e050fc65@landley.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 14, 2019 at 01:06:45AM -0500, Rob Landley wrote:
> On 5/13/19 5:09 PM, Mimi Zohar wrote:
> >> Ok, but wouldn't my idea still work? Leave the default compiled-in
> >> policy set to not appraise initramfs. The embedded /init sets all the
> >> xattrs, changes the policy to appraise tmpfs, and then exec's the real
> >> init? Then everything except the embedded /init and the file with the
> >> xattrs will be appraised, and the embedded /init was verified as part of
> >> the kernel image signature. The only additional kernel change needed
> >> then is to add a config option to the kernel to disallow overwriting the
> >> embedded initramfs (or at least the embedded /init).
> > 
> > Yes and no.  The current IMA design allows a builtin policy to be
> > specified on the boot command line ("ima_policy="), so that it exists
> > from boot, and allows it to be replaced once with a custom policy.
> >  After that, assuming that CONFIG_IMA_WRITE_POLICY is configured,
> > additional rules may be appended.  As your embedded /init solution
> > already replaces the builtin policy, the IMA policy couldn't currently
> > be replaced a second time with a custom policy based on LSM labels.
> 
> So your design assumption you're changing other code to work around in that
> instance is the policy can only be replaced once rather than having a "finalize"
> option when it's set, making it immutable from then on.
> 
> Rob
I agree it would be better to have a finalize option. Outside of my
idea, it seems the current setup would make it so while developing an
IMA policy you need to keep rebooting to test your changes?

I'd suggest having a knob that starts out unrestricted, and can be
one-way changed to append-only or immutable. This seems like a good idea
even if you decide the embedded image is too much trouble or unworkable
for other reasons.
