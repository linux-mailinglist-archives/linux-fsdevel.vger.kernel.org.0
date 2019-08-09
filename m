Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CACAA886FB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2019 01:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfHIXqO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Aug 2019 19:46:14 -0400
Received: from sonic312-26.consmr.mail.ir2.yahoo.com ([77.238.178.97]:46522
        "EHLO sonic312-26.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726219AbfHIXqO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Aug 2019 19:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1565394372; bh=wrzV/XarInPiHEpRHfWis3EQWVvXDyU7DUR2XLJRQMs=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=pr8MhrZ88wWHbiyUxNwj1QQmNcM8jn1pAFUxoRqo+97jStYOgdySipibFnGte4LmHrGq/8FbjmrTiWOrnxG++34kYHG/W2IQzyECb272nO7DPIi3EeyBhH9dEraI9rx5j+35Q57Io49wglL4n0h+e64BNk+gI4zUQDKg/i1tzcBwAZAHgQD7mnynK3omGHZq2lBVZzJpntJAwhbDoldj+okthe1jUsXr8ysNUuzLwY01dOh68B9bVznOa+CEkt0YAplwS3LRpy0R4BucvcBMY0gGhxYh7KLMOorsSCLEx85HlYuGJa1uFAL+Rm0GP91C5FxRVLgw/V1lvU6nqry8Sw==
X-YMail-OSG: lKVGdZ4VM1k5hzexu.vHBLy1e1rRc3rticDBnIqfVhmrLVqX0yEHBrjG2k.dkZU
 I3XAEiQUfnyOdfxpsWy.pF1EJrdf7RoeyqxNiDgDJHN8E.KXN5_oIrpsUhPXifDw7uhf4AFN0pSa
 2fhXKhlH61tIdJE7geFXgonrtHk0Wlc5FiG9TBwLafYSPgCP3ONSnrJDh_De1iic6erMjhnyo3B3
 p50d4FXWJGasnyFaECh3KyG142_.3Atj7hDTP9z9r4OxoVfFUI6zyYwTRWoVtBlqGgZfm9gUySdO
 B3xO9BEaZj5qqEStvA9U7Q8__0iuuNA5oOCv71kZwbc1UX_xPH8DiuX6vVY5UfvoHTcBcovxMbVb
 44vu62nSyMI2Wn3T9a96e_L3f8Ar2.JsTbQmBco51RPT0wK3U3kI7VAvpfvKxKsEjKH9uE7ZkUFt
 .PlZhRCJozcBLlWfF86ORbqKYX_MRhhdf2IU4odd6eV1vdMrPm_SkQ_m1i1R_zTueSxpwUmOrJgI
 RR7CqIbqTw1Q0q6m2LKlF4iwTeJpP0WH_l4t3e4OGnP9heCw_XyRcD0bbddj6IJDczp1MJueeQEY
 VpGo.w0HfBncp5YWWwzDNMbW_VBiMKQHN9sNVOpx35eMJWmF4Tp4bvanfbohbIM2Rr0dKq_s.i48
 DVMtPXlYfgwQ.PNgp_f1nXf.OvMougo1L_3bCh6kh5_1MZzEGfN7.NIUmPyGtULYLq5rH4y0PI2S
 AWRtuJsJ4iZKE3PuHPmK5HMkvBUjJt3FwTrUasVw3_HuIu5YG8YiU5J4shVeOb37rD_gaKiTq_Qm
 wx6dkOi6aIZ.bkm.ggdpY.P5nPsvQckm._nFwPx03Q90TSOh619jLHF9C3kd2U76Kl9IfNz_Eckr
 W0yEnWlJQ5B7cljnkwlaVR7yuF6Fxpkl17jpgQS7jsAW71IotGkf1OLEFGVkes.quiySbCnu1Pqp
 2DwEH3ri3Ppyk0KFzLanS.G4iKwm84APW.vND..uJ2qs2CRHtWw4au6SDxitOyi9fLLXTU6NwYyn
 UbkGYARt4JookJhLwK4BGHuyakdqFg_R56ejPvhZD8fNjG4Nr0B8Q0vDS1FWE4uU4TWUusptxN4I
 WpDV540RHnWyLNhQrB4rSkFweRg5cuioulb_QP6P8cJVqF5V0YdmuGEnr0baNIPb10b6_8.anvcF
 jOqXosJz.sU2tIdCH_OhQI0WfxpXIXKFuZBa3YEihDBLSABvD0s1QB.Pit8khSjjgOLQWcZsYbDx
 auSOizCsIjdtCyWyUiIiSHQc12vXN4Oc-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Fri, 9 Aug 2019 23:46:12 +0000
Received: by smtp428.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID dbebb2e24a54b3a56a55e6e4ab843319;
          Fri, 09 Aug 2019 23:46:07 +0000 (UTC)
Date:   Sat, 10 Aug 2019 07:45:59 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Gao Xiang <gaoxiang25@huawei.com>,
        Dave Chinner <david@fromorbit.com>,
        Goldwyn Rodrigues <RGoldwyn@suse.com>,
        "hch@lst.de" <hch@lst.de>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "ruansy.fnst@cn.fujitsu.com" <ruansy.fnst@cn.fujitsu.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, miaoxie@huawei.com
Subject: Re: [PATCH 10/13] iomap: use a function pointer for dio submits
Message-ID: <20190809234554.GA25734@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190802220048.16142-1-rgoldwyn@suse.de>
 <20190802220048.16142-11-rgoldwyn@suse.de>
 <20190804234321.GC7689@dread.disaster.area>
 <1565021323.13240.14.camel@suse.com>
 <20190805215458.GH7689@dread.disaster.area>
 <20190808042640.GA28630@138>
 <20190808054936.GA5319@sol.localdomain>
 <20190809204517.GR5482@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809204517.GR5482@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Willy,

On Fri, Aug 09, 2019 at 01:45:17PM -0700, Matthew Wilcox wrote:
> On Wed, Aug 07, 2019 at 10:49:36PM -0700, Eric Biggers wrote:
> > On Thu, Aug 08, 2019 at 12:26:42PM +0800, Gao Xiang wrote:
> > >     1. decrypt->verity->decompress
> > > 
> > >     2. verity->decompress->decrypt
> > > 
> > >     3. decompress->decrypt->verity
> > > 
> > >    1. and 2. could cause less computation since it processes
> > >    compressed data, and the security is good enough since
> > >    the behavior of decompression algorithm is deterministic.
> > >    3 could cause more computation.
> > > 
> > > All I want to say is the post process is so complicated since we have
> > > many selection if encryption, decompression, verification are all involved.
> > > 
> > > Maybe introduce a core subset to IOMAP is better for long-term
> > > maintainment and better performance. And we should consider it
> > > more carefully.
> > > 
> > 
> > FWIW, the only order that actually makes sense is decrypt->decompress->verity.
> 
> That used to be true, but a paper in 2004 suggested it's not true.
> Further work in this space in 2009 based on block ciphers:
> https://arxiv.org/pdf/1009.1759
> 
> It looks like it'd be computationally expensive to do, but feasible.

Yes, maybe someone cares where encrypt is at due to their system design.

and I thought over these days, I have to repeat my thought of verity
again :( the meaningful order ought to be "decrypt->verity->decompress"
rather than "decrypt->decompress->verity" if compression is involved.

since most (de)compress algorithms are complex enough (allocate memory and
do a lot of unsafe stuffes such as wildcopy) and even maybe unsafe by its
design, we cannot do verity in the end for security consideration thus
the whole system can be vulnerable by this order from malformed on-disk
data. In other words, we need to verify on compressed data.

Fsverity is fine for me since most decrypt algorithms is stable and reliable
and no compression by its design, but if some decrypt software algorithms is
complicated enough, I'd suggest "verity->decrypt" as well to some extent.

Considering transformation "A->B->C->D->....->verity", if any of "A->B->C
->D->..." is attacked by the malformed on-disk data... It would crash or
even root the whole operating system.

All in all, we have to verify data earlier in order to get trusted data
for later complex transformation chains.

The performance benefit I described in my previous email, it seems no need
to say again... please take them into consideration and I think it's no
easy to get a unique generic post-read order for all real systems.

Thanks,
Gao Xiang

> 
> > Decrypt before decompress, i.e. encrypt after compress, because only the
> > plaintext can be compressible; the ciphertext isn't.
