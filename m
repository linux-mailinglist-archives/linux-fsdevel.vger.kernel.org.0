Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FECF231FF9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jul 2020 16:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgG2OJ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jul 2020 10:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG2OJ6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:09:58 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F75DC061794;
        Wed, 29 Jul 2020 07:09:58 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 3so3117914wmi.1;
        Wed, 29 Jul 2020 07:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vkC3fvNmKNBLIFtY8s9gUSSMLaLvXlZcrAXU3Wmoa0w=;
        b=HWz4qlSCLN8duN0zFg0ocHeQRqTJjBs9yoGP64/yFcIPLUor7/d7E6l4Y1LVAb2pYt
         npipybWRRBj/4+LxMWwXqK9Nu/Cz8vCDTXhdhaH84VVrc5dY2ESVcO+84xOU+Wmyj/8l
         zeMiqNQs4L9jMC7wvqAgpZIVSbGWssrPmjM1XsUAMkIQBfcBXoGyshmLhP8BH0cRbgoa
         lqUaEYtQkP8BBH/dvsnbPl1XbkpOaYdqUcA1yeT1ETdF51djMOdBbr15zB19Jtk8xBn5
         bGQX7NAN1wOb6glAbcTyJvH61rVQPEopLf0RdoYAZfOKqr3MoLSsntdkc+ikWtvVXiLn
         7vCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vkC3fvNmKNBLIFtY8s9gUSSMLaLvXlZcrAXU3Wmoa0w=;
        b=C1rCWNxZ5W021QdW6oMucImqBwngWZ/aI5r880/l1U5rEmhFvGM8FCs8vKfYFWPr4z
         DDdMcSXGYN30AXCnKyfrab/2cToczapkknTl1kMzPhpXDws3hVwHxIBFkLMAObnlJfCy
         sJLyWEm8UM/nDHWnRnCudKZy0l0CUaptq5HwBybaunmH8S5Y1NVKeon8RFyrlY/CIX20
         Ah5Lknh3vAF+UnmFihQcztjjlkThEhak6lWNOO4ygWvrrO2cdu0XGP8uEFbTSzHNvv1J
         IDnv6zctK+/+7Jkrk4PJH2/GGJbHdNaCueybizq3Mgl5MnRMxY446Qi6vvxio7KzS7cF
         Bq3w==
X-Gm-Message-State: AOAM533FU+iSdZagNukvt2r9te+/a0hkx77+PsO/+6P5+kHZ0KuxJ3fn
        nlUwT8r3Ac6S/28h2BVQc1eEab4=
X-Google-Smtp-Source: ABdhPJyXW+bW53cuqDMz8WcVkCDkydQaO3+Q1hZ+DmtxT7lDLGPCxHSXpdUbqmNjbC0jgizGK74V+Q==
X-Received: by 2002:a1c:f70c:: with SMTP id v12mr8915133wmh.100.1596031796471;
        Wed, 29 Jul 2020 07:09:56 -0700 (PDT)
Received: from localhost.localdomain ([46.53.254.111])
        by smtp.gmail.com with ESMTPSA id i6sm5202596wrp.92.2020.07.29.07.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 07:09:55 -0700 (PDT)
Date:   Wed, 29 Jul 2020 17:09:53 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject: make oldconfig (Re: mmotm 2020-07-27-18-18 uploaded
 (mm/page_alloc.c))
Message-ID: <20200729140953.GA1650156@localhost.localdomain>
References: <20200728011914.S-8vAYUK0%akpm@linux-foundation.org>
 <ae87385b-f830-dbdf-ebc7-1afb82a7fed0@infradead.org>
 <20200728145553.2a69fa2080de01922b3a74e0@linux-foundation.org>
 <048cef07-ad4b-8788-94a4-e144de731ab6@infradead.org>
 <20200728184419.4b137162844987c9199542bb@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200728184419.4b137162844987c9199542bb@linux-foundation.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 28, 2020 at 06:44:19PM -0700, Andrew Morton wrote:
> On Tue, 28 Jul 2020 15:39:21 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
> 
> > On 7/28/20 2:55 PM, Andrew Morton wrote:
> > > On Tue, 28 Jul 2020 05:33:58 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
> > > 
> > >> On 7/27/20 6:19 PM, Andrew Morton wrote:
> > >>> The mm-of-the-moment snapshot 2020-07-27-18-18 has been uploaded to
> > >>>
> > >>>    http://www.ozlabs.org/~akpm/mmotm/
> > 
> > 
> > >> on x86_64:
> > >>
> > >> ../mm/page_alloc.c:8355:48: warning: ‘struct compact_control’ declared inside parameter list will not be visible outside of this definition or declaration
> > >>  static int __alloc_contig_migrate_range(struct compact_control *cc,
> > >>                                                 ^~~~~~~~~~~~~~~
> > > 
> > > As is usually the case with your reports, I can't figure out how to
> > > reproduce it.  I copy then .config, run `make oldconfig' (need to hit
> > > enter a zillion times because the .config is whacky)

If it helps with Enter:

	yes '' | make oldconfig

Works 99.99% of the time except when there is numeric/string option
without default value.
