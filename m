Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411997766D7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 20:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjHISB0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 14:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHISBY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:01:24 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3E41BD9
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Aug 2023 11:01:22 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99bf9252eddso18415366b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Aug 2023 11:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691604081; x=1692208881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1eZXxrGHYc5zBt/gPGhViKboEWsjh9XA5J78D9uJxOE=;
        b=qIfuNyPZJAfZ3XtkrVhKHwXNVRSOq2rkdyddQKtVHVUZh2xmlhO2HO9Ot/LISYTiUH
         Skg10Gd76KIat7lS4Wj3iw1Swiw8JF5AGJr/I1RQhBcQRqZKxVdHWK2XdN1tY0+GOdLE
         KgziID5c7Pstk5LScoarI3d3dkBLXYAAY4OUr4urb1Y03gRdYg8RuKj59NPbT5C4F5zr
         mrlxUN1DqKXoiR2vTi1QUmWtwKN5WHTpa8GJM2ML5bHIbrVo32HzrXN7SyBLwZZ1NS3p
         sEEV8KGBRCI8BXdpMJXwJLHPQxcE6X90T6RJKnWxjXPdlMyLUmPfvyHv1JLj+TXV8RmI
         fZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691604081; x=1692208881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1eZXxrGHYc5zBt/gPGhViKboEWsjh9XA5J78D9uJxOE=;
        b=LNmoDFIT1DoCR45M109FlYcL5fohbjc9GCjI6zaJotL6iJuT21h2aTiv3mSTMLBQbS
         tuJGHANrXAehCHRzLWkvTU8i0Rghm658IzjGs7T+tSPdSqx6jEpuIuVZVSeOOrjd/6ZQ
         HrQhyeBiGK9uUMHzdnz9KG8SwqEmWf5i0yJVBqw1ut8tZJ1NebCV+YHgm/a2eEiiyM9Y
         sAH6CQqFm0OtK39wyhtuyf6akaop1iZ8MnmpBkVTqIMvyuWniWbphpHR8DFQTa/CIP/z
         Xh/dA2MQV7adRkWHvYH3slFFDMR8EZgCpDMrFQibQgAIaBC23bkdn/UiGzH0aauTA7EY
         oCQA==
X-Gm-Message-State: AOJu0YzV2bL5TT88OcB7mir2VPveORkmUY0Ep0TbhzyTkWJriDOEXcK4
        zLHdfdNE3W3NFb/6BT8OIuqsZPaUGA==
X-Google-Smtp-Source: AGHT+IHGfyb0ReJKTasGUEi7h6SGIttbntWep6USRiADcD1K/quL0DOhNPLiu5sy7j6C/X9l0eUImw==
X-Received: by 2002:a17:906:5daa:b0:97d:ee82:920a with SMTP id n10-20020a1709065daa00b0097dee82920amr2327457ejv.74.1691604081034;
        Wed, 09 Aug 2023 11:01:21 -0700 (PDT)
Received: from p183 ([46.53.253.54])
        by smtp.gmail.com with ESMTPSA id mf10-20020a170906cb8a00b0096f6a131b9fsm8306864ejb.23.2023.08.09.11.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 11:01:20 -0700 (PDT)
Date:   Wed, 9 Aug 2023 21:01:18 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] adfs: delete unused "union adfs_dirtail" definition
Message-ID: <4a8f987c-bf73-46df-9986-93b015d457c6@p183>
References: <43b0a4c8-a7cf-4ab1-98f7-0f65c096f9e8@p183>
 <ZNPC+79EankpEt+k@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZNPC+79EankpEt+k@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 09, 2023 at 05:46:51PM +0100, Matthew Wilcox wrote:
> On Wed, Aug 09, 2023 at 07:35:49PM +0300, Alexey Dobriyan wrote:
> > union adfs_dirtail::new stands in the way if Linux++ project:
> > "new" can't be used as member's name because it is a keyword in C++.
> 
> $ git grep '\<new->' fs |wc -l
> 610
> 
> You cannot seriously be proposing this.

I'm just deleting unused code. :^)

	 1065 files changed, 10454 insertions(+), 10454 deletions(-)
