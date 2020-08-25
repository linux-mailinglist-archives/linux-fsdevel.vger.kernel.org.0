Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 535C1251006
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 05:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgHYDgF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 23:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728039AbgHYDgD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 23:36:03 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974E1C0613ED
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2020 20:36:03 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y206so6214867pfb.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2020 20:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=jMst9AALyVE1vuNR7TVhktCGxVDBADXL6clCiwvRDF4=;
        b=1EbY6cqHzWJ8O5xJucVD6EGWUfFV/sOP5pT0xJwxdbllnLVz47G6Zh/q/HCihEgjMF
         E+HvYQE2mzaQyPZ2NVV6CCYObcm/lxIMxDCBZZVCFuVswDSKwinMoPvFZwz0rYEny0Zk
         RvU6m5BzuenPCBtp8cnPmR2ldM9p2H3i2Zx1xr3FXQP/CbTMtAJUE3oGl/Lem9mhZk9v
         XjTHaRC7v76gEAYHy8wCVHEvHwXVyxij9SYMv83TmRoiEePGUvFgBwxSUcgik57/S7vD
         mOzWAEIqhXqkbGPwMMFV574UE/d/02sLBmeyxMpR3oQ0TnSQfnEmkhotRBPbWqp/JsSM
         hXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=jMst9AALyVE1vuNR7TVhktCGxVDBADXL6clCiwvRDF4=;
        b=GBePXMrJMjv3sooo1VmmwKlVHkZajE/XxHtoLN163QhhxNPo2tqF7c1NvMSfFhPuKX
         FuHVy1rl46zSOA3HqwFoWuxICwEpQpKwTOpRZnkkdTXvJ6pi0f2He7u6pQq7QGW8/7IK
         5LRBLbzE5a8pmw+3/7OQBICLQFe6nIQxE3O9rleXt3uIMVZoO+TKhgIHVuFCxxiBgjlF
         YbP5NrLV9cfOHtCbjKnbC8qctEP1J3655qcr2gtAbzu1SNUmnWxgoKYwyo+0voHIVojh
         U0VaeaIRnaA1dPgFmkxyyGGCQxCf3x9InhBUyaDcV1cocJExaZSFUfFOGi5E1mE3lj7m
         q5Gg==
X-Gm-Message-State: AOAM531bhd52OGK9/t8YMoufDat5hvSNruAVSlULbGW6oqe58yH6qm6S
        ISEp54cW/BugrRdQH/B8Qjn9fw==
X-Google-Smtp-Source: ABdhPJwMrxZOJCEdo6Oiehi+gc/8cfNjuXrzzHMWlxrsTYr5jEk0TdfzRtpVv16lWhN5uoC6za1EeA==
X-Received: by 2002:aa7:858c:: with SMTP id w12mr1295615pfn.157.1598326563022;
        Mon, 24 Aug 2020 20:36:03 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id x5sm1877284pfj.1.2020.08.24.20.36.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 20:36:02 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <E47B2C68-43F2-496F-AA91-A83EB3D91F28@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_23D8BB5C-5128-4552-921A-F0AEEE76FFB1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 9/9] iomap: Change calling convention for zeroing
Date:   Mon, 24 Aug 2020 21:35:59 -0600
In-Reply-To: <20200825032603.GL17456@casper.infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
To:     Matthew Wilcox <willy@infradead.org>
References: <20200824145511.10500-1-willy@infradead.org>
 <20200824145511.10500-10-willy@infradead.org>
 <20200825002735.GI12131@dread.disaster.area>
 <20200825032603.GL17456@casper.infradead.org>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_23D8BB5C-5128-4552-921A-F0AEEE76FFB1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Aug 24, 2020, at 9:26 PM, Matthew Wilcox <willy@infradead.org> wrote:
> 
> On Tue, Aug 25, 2020 at 10:27:35AM +1000, Dave Chinner wrote:
>>> 	do {
>>> -		unsigned offset, bytes;
>>> -
>>> -		offset = offset_in_page(pos);
>>> -		bytes = min_t(loff_t, PAGE_SIZE - offset, count);
>>> +		loff_t bytes;
>>> 
>>> 		if (IS_DAX(inode))
>>> -			status = dax_iomap_zero(pos, offset, bytes, iomap);
>>> +			bytes = dax_iomap_zero(pos, length, iomap);
>> 
>> Hmmm. everything is loff_t here, but the callers are defining length
>> as u64, not loff_t. Is there a potential sign conversion problem
>> here? (sure 64 bit is way beyond anything we'll pass here, but...)
> 
> I've gone back and forth on the correct type for 'length' a few times.
> size_t is too small (not for zeroing, but for seek()).  An unsigned type
> seems right -- a length can't be negative, and we don't want to give
> the impression that it can.  But the return value from these functions
> definitely needs to be signed so we can represent an error.  So a u64
> length with an loff_t return type feels like the best solution.  And
> the upper layers have to promise not to pass in a length that's more
> than 2^63-1.

The problem with allowing a u64 as the length is that it leads to the
possibility of an argument value that cannot be returned.  Checking
length < 0 is not worse than checking length > 0x7ffffffffffffff,
and has the benefit of consistency with the other argument types and
signs...

Cheers, Andreas






--Apple-Mail=_23D8BB5C-5128-4552-921A-F0AEEE76FFB1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl9EhyAACgkQcqXauRfM
H+A2bA/+PJl5m7FnhjTWHQEwftqKx/Ihjoc2ef7C7c8Kdyb+cda3QwWzm+mFKLB/
S0ORVi1pC9acc6wTSQNKa38aIj6o/oqeAevz2fXiAF4K0P8JrgWhH0WQE2tFry5O
ZFcS2+ppn14u69WkcEvtFG7kXfT2KFf8LfPy5/nXTTJFodVFFVg1kaa6UNyfR6QB
mLG0x8YD7QoAU8RmUgbXR2E7j/2JItJyIdDzMIm4O6Bc1B5akrj679DlYgyW6pb2
Po4L23OEDHHB+dNEvJuY3XpjEg6cbb6AvB8oZGMBfMGoVs1/zV3OcMfDqyJ9Wm7/
sPszYKLpnpZyVTV3tKd7u6p8WAbQJSdlqNj33OIiXWg6EPtqdOnCcDO9Bx0+CHhf
UBDtcjgXGZvJ5gsurTfQHr1hz40x2MIbkwpsxuy5ogal1kO4eQJZvfCVgsUR4n6c
4TkI1vEYW6GGxaEOvXSZuTtRccIJkmnNeUHSOrl5XTMjfVg9UsiueKtrkjkMLo+s
5sOQTI/+4ocYeccNJObLDwj4ENDOahJz0G7lM5C4R3lBCb+RmBvjqDmqkI1zmonN
f7+/jKRPT1p6V7COLZ/SHg4HY9M6EV3lm4tMXsiu445rWTUR0Fi3bKFOeN/+E9wg
a+wwO+kzZUswiDVqDtfpZmnON1msvguMHvgEfIwormwE9FwU1GQ=
=dr3G
-----END PGP SIGNATURE-----

--Apple-Mail=_23D8BB5C-5128-4552-921A-F0AEEE76FFB1--
