Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEAA65AB7A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Jan 2023 21:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjAAUHu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Jan 2023 15:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjAAUHt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Jan 2023 15:07:49 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2E2273C
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 Jan 2023 12:07:48 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id b145so13479524pfb.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Jan 2023 12:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:content-id:mime-version:references:in-reply-to:cc
         :to:subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Xxl7U3B1v3NJ8oz4U1/+05qRwO05QIEsUJJ/AFZS/M=;
        b=L6GI1YFEFRAmMw9jqMVlI6Egep5AfuWi8WMwMUXGqbdaTofmSQ+w1kqzbs2DmGXa6H
         ZW/+9B3RNafnvQOkbB63odteG8JyghrNn3wLlPkeSDFsYkOXw2Jv/bcPLIZaM+SlXDAG
         ugDSYh96aikluExYIvE14HWjczYBtDGf4GNZuPjadOhGgh4hnLGxVhnOPsHvsIayYOmB
         KDZUf8fXWJGYHOd41NXJKbiiOsgFKNdI8cWqj2abp9ScFbbxrFnMfHLzFebDHVdlWUjy
         gXbxjTk3DySUh5yDw9UbI4MYFtcpDs92vG1Zh4dUTjr4+CdfxsWHWDqtc3L7/SZuGHE3
         ikKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:content-id:mime-version:references:in-reply-to:cc
         :to:subject:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Xxl7U3B1v3NJ8oz4U1/+05qRwO05QIEsUJJ/AFZS/M=;
        b=kaMLnqNKQEfepdVnnJ4WnGTKJQ/Jd/JR0RCeLDBoyvE5RedlnXDX09AjEbVi2Ws4j7
         dxLTGoUbVbN7q3BPcoyP/OYC3V5YQn4wFlh9QiL78T5qS45fvQkXQFPlD4aCpJfjhbGK
         QiFvaM5k+rf4jUJwAcs7sR8XBYulqqmykUyf9N1qAB9oYs6hjRv1M2ObKyQxAgsZX7jK
         zQYSoBy+L+sJ6/ESIah9Fy84L/qocygbZzTXwMOYEQCBEQpQbcZU4ZjsbDla9D45N6vT
         uvqwGHMfWiaRQoQsQPXQjefeWbWwBXuV+92YfXB1I49ne+DW5ERjkD3vAU0I1M5JV7dl
         WMQg==
X-Gm-Message-State: AFqh2kqmNfYdQDNIczLpOd8B8tupantqSd1N8P+hEarMl2fv+q2xQfBl
        eA22WXRjuRH1VDfi9IMkZZY=
X-Google-Smtp-Source: AMrXdXt3X+5NylHJvAHXJRwLUECR8D49Z++uadQ7xQHMuOjcVivMVDc3DRKN9u6JzWdBOaPDp5qMWQ==
X-Received: by 2002:a62:1614:0:b0:580:dd4d:43bc with SMTP id 20-20020a621614000000b00580dd4d43bcmr29268291pfw.26.1672603668006;
        Sun, 01 Jan 2023 12:07:48 -0800 (PST)
Received: from jromail.nowhere (h219-110-108-104.catv02.itscom.jp. [219.110.108.104])
        by smtp.gmail.com with ESMTPSA id 199-20020a6216d0000000b00580f224cdf6sm13568481pfw.203.2023.01.01.12.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 12:07:47 -0800 (PST)
Received: from localhost ([127.0.0.1] helo=jrobl) by jrobl id 1pC4cU-0006l9-5E ; Mon, 02 Jan 2023 05:07:46 +0900
From:   "J. R. Okajima" <hooanon05g@gmail.com>
Subject: Re: [GIT PULL] acl updates for v6.2 #forregzbot
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <2aa5cc7e-ca00-22a7-5e2f-7eb73556181e@leemhuis.info>
References: <20221212111919.98855-1-brauner@kernel.org> <29161.1672154875@jrobl> <2aa5cc7e-ca00-22a7-5e2f-7eb73556181e@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <25985.1672603666.1@jrobl>
Date:   Mon, 02 Jan 2023 05:07:46 +0900
Message-ID: <25986.1672603666@jrobl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thorsten Leemhuis:
> Thanks for the report. To be sure below issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
> tracking bot:

Hold it!
I'm not sure whether this is a regression or a bugfix. Or even it maybe
a problem on my side. I'm still struggling to find out the reproducible
way.


J. R. Okajima
