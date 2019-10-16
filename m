Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86C2DD9349
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 16:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405716AbfJPOD6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 10:03:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44044 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405714AbfJPOD6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:03:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id z9so28211732wrl.11;
        Wed, 16 Oct 2019 07:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UkCPOkyDARfo8k/pBvvcA0h9m0lAAi+VfYgojWm4kgk=;
        b=cY9dsuzoAPwxU/XF5YOyYMjat23Qun9g3x6ILdtSx/ggQRqIePmLDkjzG2p5jnu/K2
         8E1+2ITKF3H/fb7zzkOun+aQOQ0hhp94nirrHcqfEuc/HjDynTAHWZpgePCE2K1OZMfs
         pjfc9gfZIvlmAKztRuOpcLCtda7izI0fM9fWl2oJlxCnKhV+kSNYJlU3gVDyh65z781h
         1Cg5vWoK9PxSRedm1NUZ9it8nmzgzziT3YRqK7fp6bM6hn3bnxpeQA5hgmmxmb7u4te/
         60PH4xXqvpKLPy3o8g7wNFCMhWNDKXG3yVULIqqwRVOr4ZMY8gmr/nhu6mrWaVoM2Y8M
         4YyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UkCPOkyDARfo8k/pBvvcA0h9m0lAAi+VfYgojWm4kgk=;
        b=FBmeS18BY5Kgq6DgS6lVC+OP8oj9Hs1pwIB6IZCPXfr425bmnHlJY2ZePTW9yR5/Ef
         w/PIv9dPD1s+UcyO4uBWgGUvmOS8bMNCke3LObZ66RvKnUiRYvSV1ZWqJlhxfXf1KdP0
         yyUmdi6WwIjTURTUQdm+ipONsFn9eeSBAgZgoa4Iv/X8WUHdfQlqASMq9BUilHnaVk5k
         +r9+b2bis5LypPMU0AlFaUfgPcTpalBK/EcOO7zF6GAUKzYN8oCJUg36bRd66Gz1lu2k
         ENFsQ6ivfONQLF7tXczTr1aBD+c9nnLvhtpsOjF7ea8Tn6v+GkHtT+r4FKE9TivKLe+r
         Wg4g==
X-Gm-Message-State: APjAAAW1Yni++Wh1uUmYqL0kO7j9gC4WHQ0vJobGzi0yXrJmIs0FIi5X
        K5yksUM+oEHTQ3HSDk248LM=
X-Google-Smtp-Source: APXvYqwVB1pZhXJU7zyV30yowyh/v7HB68SaAJm2+nDZiRFa1Y5kqu3QvOa4SMlU88KEt9f6U3tzHw==
X-Received: by 2002:adf:ecd0:: with SMTP id s16mr2842961wro.65.1571234635696;
        Wed, 16 Oct 2019 07:03:55 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id r27sm67512626wrc.55.2019.10.16.07.03.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Oct 2019 07:03:54 -0700 (PDT)
Date:   Wed, 16 Oct 2019 16:03:53 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
Message-ID: <20191016140353.4hrncxa5wkx47oau@pali>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
 <20190829205631.uhz6jdboneej3j3c@pali>
 <184209.1567120696@turing-police>
 <20190829233506.GT5281@sasha-vm>
 <20190830075647.wvhrx4asnkrfkkwk@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190830075647.wvhrx4asnkrfkkwk@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Friday 30 August 2019 09:56:47 Pali Rohár wrote:
> On Thursday 29 August 2019 19:35:06 Sasha Levin wrote:
> > With regards to missing specs/docs/whatever - our main concern with this
> > release was that we want full interoperability, which is why the spec
> > was made public as-is without modifications from what was used
> > internally. There's no "secret sauce" that Microsoft is hiding here.
> 
> Ok, if it was just drop of "current version" of documentation then it
> makes sense.
> 
> > How about we give this spec/code time to get soaked and reviewed for a
> > bit, and if folks still feel (in a month or so?) that there are missing
> > bits of information related to exfat, I'll be happy to go back and try
> > to get them out as well.

Hello Sasha!

Now one month passed, so do you have some information when missing parts
of documentation like TexFAT would be released to public?

> Basically external references in that released exFAT specification are
> unknown / not released yet. Like TexFAT. So if you have an input in MS
> could you forward request about these missing bits?

-- 
Pali Rohár
pali.rohar@gmail.com
