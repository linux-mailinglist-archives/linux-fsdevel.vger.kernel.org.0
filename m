Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81F061AE00
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2019 21:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfELTn2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 May 2019 15:43:28 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35566 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfELTn2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 May 2019 15:43:28 -0400
Received: by mail-qk1-f194.google.com with SMTP id c15so6803038qkl.2;
        Sun, 12 May 2019 12:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FjkT8c0mYt5eWOwRncdXrIt5s86GnuaQ8y74QwZDscY=;
        b=fPKk/QKFELPkBCrMzjUg8GR7sOcdZ3YXVrhQo5F48CjmM2qmUgTqM/kqml7HljtQ6u
         WKtahah9PN3uW+IY8Wj35Pzz13qV1pHm2rOK9GeTHxa7P+tKhwkPbBT867K4kiidZMO5
         oPfH+vk/OhFvYDSEGf5osin8Be7nAf9vXLL5T6Nmmwhxy8w39qf5nevbdYprmCeQymMu
         1bGDYzT6DGQ3FSBKgbdvDcnk2MpbSY/63m9yd+eknnFwZ3O0pwxsaTMv0+utJQjb4G2E
         cYx5CQ9XtjVSAuPa/QoVfLrOzRvH+2/oZdLB28w4AMIs0iAGrWeyIy0M+4qeRKQdv2To
         j/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FjkT8c0mYt5eWOwRncdXrIt5s86GnuaQ8y74QwZDscY=;
        b=AOluskE79iQebeEjcLVTKjfGxWcXwC2WmITR80BJTiagPDd17pg8LYzpSepfLc/NGA
         lb9TlQa1ICHpss17oNzagkXtawbi+kVRb5Ye3DhYd9G676wlEm1tXrCmorlgOVrn17Fp
         XxcNgmQX0VA6Qh+WDmQaKJEF3zOWh3SpbFSsoo6xZGQlFJ1n3uZ4zOIVMD6o5OuLEYSb
         G5Ek07JbINT5FrbcnEoEl8sedaZTqvhW+lTO9kqdthgFwv5Z7MR81vfz3YSYAJkfVlnE
         hYh2mt56X3/UArkSfTACaVhfop3vl+Q22vb2yJMaxthwozVi7ThMcyxgb4YOBd0K7pPC
         KV9A==
X-Gm-Message-State: APjAAAUEN/3FVM1bnJZTvi7Q9+G6rBPZNPARokQQ2d3qfV3Eqs59YVSN
        tiTTMYKTYyeRaeffKmz+kcs=
X-Google-Smtp-Source: APXvYqyF22Y4YKd94kUWZgDu03sl+kSYsut5UIiJVaJlD6bstj3k3HWXDt3m2dr+eVJxOhK72yIRqA==
X-Received: by 2002:a37:9881:: with SMTP id a123mr19005060qke.72.1557690207088;
        Sun, 12 May 2019 12:43:27 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id e4sm2266463qkl.17.2019.05.12.12.43.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 12:43:26 -0700 (PDT)
Date:   Sun, 12 May 2019 15:43:25 -0400
From:   Arvind Sankar <niveditas98@gmail.com>
To:     Rob Landley <rob@landley.net>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        initramfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
Message-ID: <20190512194322.GA71658@rani.riverdale.lan>
References: <dca50ee1-62d8-2256-6fdb-9a786e6cea5a@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dca50ee1-62d8-2256-6fdb-9a786e6cea5a@landley.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 12, 2019 at 05:05:48PM +0000, Rob Landley wrote:
> On 5/12/19 7:52 AM, Mimi Zohar wrote:
> > On Sun, 2019-05-12 at 11:17 +0200, Dominik Brodowski wrote:
> >> On Thu, May 09, 2019 at 01:24:17PM +0200, Roberto Sassu wrote:
> >>> This proposal consists in marshaling pathnames and xattrs in a file called
> >>> .xattr-list. They are unmarshaled by the CPIO parser after all files have
> >>> been extracted.
> >>
> >> Couldn't this parsing of the .xattr-list file and the setting of the xattrs
> >> be done equivalently by the initramfs' /init? Why is kernel involvement
> >> actually required here?
> > 
> > It's too late.  The /init itself should be signed and verified.
> 
> If the initramfs cpio.gz image was signed and verified by the extractor, how is
> the init in it _not_ verified?
> 
> Ro

Wouldn't the below work even before enforcing signatures on external
initramfs:
1. Create an embedded initramfs with an /init that does the xattr
parsing/setting. This will be verified as part of the kernel image
signature, so no new code required.
2. Add a config option/boot parameter to panic the kernel if an external
initramfs attempts to overwrite anything in the embedded initramfs. This
prevents overwriting the embedded /init even if the external initramfs
is unverified.
