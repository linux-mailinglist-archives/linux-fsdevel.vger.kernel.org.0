Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2126F6AF06D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 19:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbjCGSae (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 13:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjCGS37 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 13:29:59 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D040ADBC2;
        Tue,  7 Mar 2023 10:23:31 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id y10so8655903pfi.8;
        Tue, 07 Mar 2023 10:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678213411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g+U067obUU4UJU2lEOFDwL66pTG82HP6FRLtGVTOl5M=;
        b=HH+jtkkYKb6ejija9whaj53edit8scZIjTX1rAvAJ2ecKLNFvhC/d9YqoZZ2hQzCHH
         VtRIY11oEcQG5Jid8043xsvD1ikhTOJ3RqioZTn6IMuxF01twB0kfH8ssQ8k6Jx6hu+Y
         h78z1g2PRbp5L0Eo93DYbJ5P6VgcohogpqNa+NcpHPG0YM3SFeEF8PUQh0AUBkQ+1z9I
         17rHhIXV9OSWo4OUl4rKKLe+Jd8YNF8scxeJMEIiz2s+GXDvHSoQA7MftWlSp6Dp1lmJ
         CqOxoWVMxIPGUcnlp58lTggBSXmTUgcFSMpKsQViK2IlsjjrcTNG9YzNBs5UGz8aoGMC
         6lsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678213411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+U067obUU4UJU2lEOFDwL66pTG82HP6FRLtGVTOl5M=;
        b=44iUJwHzRAhOu0eS2Gie7MQvZotQhGMQngm3B+sbNOf87vBy68OtxkYkCd17HxMVaZ
         CWEJ87lMjvNb/WGdQafjQPke0d/bIIJBxq3dC5fV7cgGHSNjVJ4topATg/axNwnJRK5Y
         Lj9FPdv0buWL7RJJheqgLZTHvjOEwwzTW8D3x9chOLwWyXtvEGG07Xcs0XHWfEP5UUBB
         cOz0HlIPIV4cRRMY31NZtMEg5RB/tHldyhpYTw+gkAx3YhJXy+wcgpuOWg5N5hqKHsNS
         2nBE3gq2l0MWBhxLRYL91t5KKSqe9QvZ+MNE5eR0QFHW3zSForX2OuAz5+SCNLwDk6dt
         +qwA==
X-Gm-Message-State: AO0yUKUtw/fLUAJDJR9Vh/ql9PtPON8aq2JKE/EutTi5pBW6/Q4scQDs
        CvZ5KTph2lb31O+7iL/g5jrILVhVb9WyHg==
X-Google-Smtp-Source: AK7set84L+dfmEYyARYzHxkHL4mjWxSD7qVqL6qwQLFtYM+YjK8261txqNXP+EiyIUcshnBe9Bmckw==
X-Received: by 2002:a62:f24c:0:b0:5de:a362:ecf1 with SMTP id y12-20020a62f24c000000b005dea362ecf1mr77690pfl.0.1678213411252;
        Tue, 07 Mar 2023 10:23:31 -0800 (PST)
Received: from ip-172-31-38-16.us-west-2.compute.internal (ec2-52-37-71-140.us-west-2.compute.amazonaws.com. [52.37.71.140])
        by smtp.gmail.com with ESMTPSA id k15-20020aa7820f000000b005d4360ed2bbsm8152734pfi.197.2023.03.07.10.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 10:23:30 -0800 (PST)
Date:   Tue, 7 Mar 2023 18:23:29 +0000
From:   Alok Tiagi <aloktiagi@gmail.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "hch@infradead.org" <hch@infradead.org>,
        Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [RFC 2/3] file: allow callers to free the old file descriptor
 after dup2
Message-ID: <ZAeBIcZvQsB2N7eq@ip-172-31-38-16.us-west-2.compute.internal>
References: <20230302182207.456311-1-aloktiagi@gmail.com>
 <20230302182207.456311-2-aloktiagi@gmail.com>
 <bef11c18fa234948bcab0316418f04aa@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bef11c18fa234948bcab0316418f04aa@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 02, 2023 at 10:21:11PM +0000, David Laight wrote:
> From: aloktiagi
> > Sent: 02 March 2023 18:22
> > 
> > Allow callers of do_dup2 to free the old file descriptor in case they need to
> > make additional operations on it.
> 
> That doesn't read right at all.
> 
> Whether or not this is a good idea (or can be done differently)
> the interface is horrid.
> 
> >  	if (tofree)
> > -		filp_close(tofree, files);
> > +		*fdfile = tofree;
> 
> Why not:
> 
> 	if (fdfile) [
> 		*fdfile = tofree;
> 	} else {
> 		if (tofree)
> 			filp_close(tofree, files);
> 	}
> 
> Then existing code just passes NULL and the caller can't 'forget'
> to intitalise fdfile.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

thank you for the review, I'll fix it in v2
