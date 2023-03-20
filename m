Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7E66C0C3D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 09:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjCTIaJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 04:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjCTIaI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 04:30:08 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC703CC1B;
        Mon, 20 Mar 2023 01:30:06 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h17so9456239wrt.8;
        Mon, 20 Mar 2023 01:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679301005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IOF4ZXLbqCUFP0rJHH2mzd0wteSSnr5LaAAXjkDeZsI=;
        b=qqzTKoX6mjNXfOi1lncIPMjRKAtzBqwnFFPw+i/pc7L0cD+zJMKHzmGTmCxGt8um0g
         UE2yiBmZopbmFLyVnd+83qZClYw2gI3s4zVheaCIJUYZvYERTdE5qYrZvhwYWgR6LZzX
         6eP81zC/vO3yVa8wi2ppKow1ZeOGaDrRtyRu8o0MSRPrwnbOuCtpv2fpgEoe7mxKT/6Z
         2MIxQTHZeLWK9yd+tC70pZW+jzB4RxdNxVtqQtTDd3tisB5oez4PMxU/y1OC+JBb+W3Q
         6nd0EtcbtEuKE/eu+y6I1aBhfYDJU4B3MxrS13E3nSY+vdEiUmwyyPGHemR+y0Bu+6Bt
         drXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679301005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOF4ZXLbqCUFP0rJHH2mzd0wteSSnr5LaAAXjkDeZsI=;
        b=NOtKoyAnwOyvmgf/+bBV5b2IA2CAETxZQ8M5+Fnov50iqflN19r70W02qzLYBO1+/P
         h7lm6b+e11MIVi1+L7Q6x+0RfbXnyyHsrrGMqBOrvPs3+biflTc382ajE4NFDxvPy/8S
         eYq0XFGgQw63G7YQL6JK07yVUX2Ln/iM83CE8jwV+ZuaE48Z4HvRJay+2njFpDQ3qSiC
         2241CWbycsLjKLdCaVgly725cw1ZPqvXr1zAx3XMnBChdAwJAmxE6L/xGk39038OYssx
         Sj6TJfl4zYmIJwdNPiFBU7ezTilPsjt176Xlnja0ostIR+QcupiVe17LpwpPzdprfiY2
         l4OA==
X-Gm-Message-State: AO0yUKWyWZ3SfYxnQY9wcqrC1jc1WVX3kbRYgvjj3vKTAnY99NdhV1qn
        602UHfMXaB5EqHBzalpg88msFLHIzDs=
X-Google-Smtp-Source: AK7set9V17xN1GV2zmXnzgZRsia56c9Egzq/+s2UUqUAebggUDpwcq2uZ0zAI5tFk9trI2loLG5L+g==
X-Received: by 2002:a5d:56c8:0:b0:2c8:c440:cb05 with SMTP id m8-20020a5d56c8000000b002c8c440cb05mr12763870wrw.55.1679301005101;
        Mon, 20 Mar 2023 01:30:05 -0700 (PDT)
Received: from localhost (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.gmail.com with ESMTPSA id p5-20020a5d4e05000000b002d75909c76esm1396888wrt.73.2023.03.20.01.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 01:30:04 -0700 (PDT)
Date:   Mon, 20 Mar 2023 08:30:03 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Matthew Wilcox' <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH 4/4] mm: vmalloc: convert vread() to vread_iter()
Message-ID: <ec321d33-37de-4b0e-bce9-c8539a9b1c5d@lucifer.local>
References: <cover.1679183626.git.lstoakes@gmail.com>
 <119871ea9507eac7be5d91db38acdb03981e049e.1679183626.git.lstoakes@gmail.com>
 <ZBZ4kLnFz9MEiyhM@casper.infradead.org>
 <63c98c518c1e4bfbb36c5295ba7c959d@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63c98c518c1e4bfbb36c5295ba7c959d@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 19, 2023 at 10:28:12PM +0000, David Laight wrote:
> From: Matthew Wilcox
> > Sent: 19 March 2023 02:51
> >
> > On Sun, Mar 19, 2023 at 12:20:12AM +0000, Lorenzo Stoakes wrote:
> > >  /* for /proc/kcore */
> > > -extern long vread(char *buf, char *addr, unsigned long count);
> > > +extern long vread_iter(char *addr, size_t count, struct iov_iter *iter);
> >
> > I don't love the order of the arguments here.  Usually we follow
> > memcpy() and have (dst, src, len).  This sometimes gets a bit more
> > complex when either src or dst need two arguments, but that's not the
> > case here.
>
> And, if 'addr' is the source (which Matthew's comment implies)
> it ought to be 'const char *' (or probably even 'const void *').
>

Ack, I'll update on the next respin.

> 	David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>
