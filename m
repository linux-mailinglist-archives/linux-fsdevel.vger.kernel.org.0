Return-Path: <linux-fsdevel+bounces-65-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5124A7C5565
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 15:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B9CF2824C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 13:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8EB1F93A;
	Wed, 11 Oct 2023 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KZuSE21D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1B61F198
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 13:27:10 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496E6B0
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 06:27:08 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40651a726acso63323275e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 06:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697030827; x=1697635627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7sb7D9HOHQNMydcxnBv13OfNd2mqurTiUr3UspR5ooI=;
        b=KZuSE21DIT/QF5S5BRX51M/e3Z1BIJjgQ1UDFyW17Q3UgNwn4t3TmqYUWoolb1VwqH
         hv0dh0ZJuLLZsFbCDbF3ZqsE1gBR2CicwOM61JlvCBhUa+qxO+I06TXc1JlZphLkHuQA
         4IvEMyWl03bnK3w+RpP0/gXZCP3OiAupQb1oxYs0+9f48spdGV+TlB+/+tW0l0Ngh9eW
         LmBNhbbMliPAz1/Q2c3eW3sgGmiXyHDNGAD+vKjQD0IdpQK75TJsuO2udvugaPpthS8P
         q8FDAFBl1j4+6XDPUwiHAOMeq7UjWb7K+DktLwT//5F0mtiHMw8hGZO808/6SzQ6keJG
         DZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697030827; x=1697635627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7sb7D9HOHQNMydcxnBv13OfNd2mqurTiUr3UspR5ooI=;
        b=hOsOZx1d8xvMGN7vjdJg1mEyX0i2D7+B61DBdRK0mu2y7NrFaCD2L18800KoDJe0PU
         I9h6+bH8HSUjGItCm4v0L+ww8jBgzmK7xumedpFCTHqvNMo1HxritXyEvFLwupfy+lRX
         Cbc5GRAEtrSS0h2vSHXlS8uRwFaQSUw/cFa6oIr4Yd/cGBsyCNnQAKl+rnd3sjS7AdnQ
         bE2i+WqPg9k/mTvkyC5rAnW8UmxBYZfzpQDlKDcwcp9tLWnyqJfZMlRyfqHmZ/1o1cHv
         frKeuyEinBATrT7EyO4NtaDfPN8tZTptS3baC7+SD81QSDI2R3XwfSy1zPNiX4DgHrRq
         hHAQ==
X-Gm-Message-State: AOJu0YwrAoxNUV1wRpmEsCWRGUhTtVjMFHgUjmrcdg58nIUuoE03aiiR
	h0LmpcJ2PO3quG096qB1kAz4UA==
X-Google-Smtp-Source: AGHT+IHdzjXeYl0Sj/71enbZnXpMpL2LA1GgesvlgQOVgPqClnz6+dwC2NysdkRMCr/+oh3IG3Jo4g==
X-Received: by 2002:a05:600c:2284:b0:401:b493:f7c1 with SMTP id 4-20020a05600c228400b00401b493f7c1mr19620544wmf.35.1697030826606;
        Wed, 11 Oct 2023 06:27:06 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id bd5-20020a05600c1f0500b004030e8ff964sm19358856wmb.34.2023.10.11.06.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 06:27:05 -0700 (PDT)
Date: Wed, 11 Oct 2023 16:27:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: ceph-devel@vger.kernel.org, dhowells@redhat.com,
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [bug report] libceph: add new iov_iter-based ceph_msg_data_type
 and ceph_osd_data_type
Message-ID: <b261fcc8-681d-414c-a881-453635c8bd90@kadam.mountain>
References: <c5a75561-b6c7-4217-9e70-4b3212fd05f8@moroto.mountain>
 <87c8dc9d4734e6e2a0250531bc08140880b4523d.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87c8dc9d4734e6e2a0250531bc08140880b4523d.camel@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 08:06:59AM -0400, Jeff Layton wrote:
> On Wed, 2023-10-11 at 12:50 +0300, Dan Carpenter wrote:
> > Hello Jeff Layton,
> > 
> > To be honest, I'm not sure why I am only seeing this now.  These
> > warnings are hard to analyse because they involve such a long call tree.
> > Anyway, hopefully it's not too complicated for you since you know the
> > code.
> > 
> > The patch dee0c5f83460: "libceph: add new iov_iter-based
> > ceph_msg_data_type and ceph_osd_data_type" from Jul 1, 2022
> > (linux-next), leads to the following Smatch static checker warning:
> > 
> > 	lib/iov_iter.c:905 want_pages_array()
> > 	warn: sleeping in atomic context
> > 
> > lib/iov_iter.c
> >     896 static int want_pages_array(struct page ***res, size_t size,
> >     897                             size_t start, unsigned int maxpages)
> >     898 {
> >     899         unsigned int count = DIV_ROUND_UP(size + start, PAGE_SIZE);
> >     900 
> >     901         if (count > maxpages)
> >     902                 count = maxpages;
> >     903         WARN_ON(!count);        // caller should've prevented that
> >     904         if (!*res) {
> > --> 905                 *res = kvmalloc_array(count, sizeof(struct page *), GFP_KERNEL);
> >     906                 if (!*res)
> >     907                         return 0;
> >     908         }
> >     909         return count;
> >     910 }
> > 
> > 
> > prep_next_sparse_read() <- disables preempt
> > -> advance_cursor()
> >    -> ceph_msg_data_next()
> >       -> ceph_msg_data_iter_next()
> >          -> iov_iter_get_pages2()
> >             -> __iov_iter_get_pages_alloc()
> >                -> want_pages_array()
> > 
> > The prep_next_sparse_read() functions hold the spin_lock(&o->o_requests_lock);
> > lock so it can't sleep.  But iov_iter_get_pages2() seems like a sleeping
> > operation.
> > 
> > 
> 
> I think this is a false alarm, but I'd appreciate a sanity check:
> 
> iov_iter_get_pages2 has this:
> 
> 	BUG_ON(!pages);
> 
> ...which should ensure that *res won't be NULL when want_pages_array is
> called. That said, this seems like kind of a fragile thing to rely on.
> Should we do something to make this a bit less subtle?

Nah, forget about it.  Let's just leave this conversation up on lore so
if anyone has questions about it they can read this thread.  The
BUG_ON(!pages) is really straight forward to understand.

regards,
dan carpenter


