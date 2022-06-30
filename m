Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE59D561709
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 12:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbiF3KCF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 06:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbiF3KCE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 06:02:04 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520FD43EC3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 03:02:02 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 92E7E3F177
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 10:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1656583320;
        bh=wIYh+/Ozpb80cqbgI0j8SCGA1rmqDwRVQ0ZfOk2tveM=;
        h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type;
        b=IAQn3QzpjJthKZ3HpV/FUcF5oZhy0AqwDqHY33bLHGiw9sfzv440L0aMztmTEc842
         Fq2Pahd/2t9zqP+6TcC9nLSAsGigS33e+ChHzgawVsRsgVR1CMeFdLBE5Qpqd7TbQP
         5pJYnfZ3W/OF9F+pdNBZQHXh7hK216AH1xKHdEtTktQnfeCXECNluYug7RmxNv7sTP
         rbw7YvdKD+tsDNVaHDYwFWxq8Kq/MyoX02cxXfNv1JdgfVRILU2jFYjvwpTartHBjl
         BSAGkAqJovmo9jNqZ5t7ZD/68LWhSSiPr6EmW/9I8uKZ3Ukq/4/kE0Bf8ZujjZ/NUI
         u3F4LGQz7snkA==
Received: by mail-ed1-f70.google.com with SMTP id v16-20020a056402349000b00435a1c942a9so14073558edc.15
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 03:02:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wIYh+/Ozpb80cqbgI0j8SCGA1rmqDwRVQ0ZfOk2tveM=;
        b=xfVlv+RD30sqVfCyiHnAK8jT1XCkUHwto+8XmHROouOouP7OibrsyvNRnK5Nr0lQFy
         3LHPXRHbijQGsPrsrVk8gmnHQp3imwrwCHbjAQyVn+JCHl/1ESNuc+F27WwR8tUDFB7L
         7R7W2XT/+cpW8N6esJJ1L/EjTqfMziJ9W6Gqmf9MD48tH+whVWcgDdCcIk+jga5lpxMb
         WIlrNnrbifDPiNXaQlvrY5C61R4pjKAQLZKdNr9bUc77BMmII0J+pl0qIT28GjDHt8I6
         SaBPhUFyuYB89VKUuBkNVB6tZpcm9Un0ZX49OYO1KMaGQBEea1T3fcdLY2/Pu3p5aBYr
         kYCQ==
X-Gm-Message-State: AJIora+EtxNBYrjhQYhjfKKE9z1ZzKXgpOqXpmdDdeRBIrsYSQF0BUKO
        J5EjXDw5tG5YpLErxjwWxHYiW13ZgWPMFP68LeECDL+iwFFECYLHXO+M1UURnbbOW3waniobYcv
        PGKmr7TkTdEZP68RGiYsZZFeFkPIxLOB2NeK6jf1uR4k=
X-Received: by 2002:a17:906:6146:b0:722:f8c4:ec9b with SMTP id p6-20020a170906614600b00722f8c4ec9bmr8477892ejl.708.1656583320338;
        Thu, 30 Jun 2022 03:02:00 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vdDtvXrzIADOYaPgD1LYAc9jmzgUxML4F7NW1hAVyacDhmAXcIjpfNz5/zgEYUzHTVOctNRQ==
X-Received: by 2002:a17:906:6146:b0:722:f8c4:ec9b with SMTP id p6-20020a170906614600b00722f8c4ec9bmr8477878ejl.708.1656583320184;
        Thu, 30 Jun 2022 03:02:00 -0700 (PDT)
Received: from localhost ([2001:67c:1560:8007::aac:c03c])
        by smtp.gmail.com with ESMTPSA id d3-20020a1709063ec300b0072629cbf1efsm8828502ejj.119.2022.06.30.03.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 03:01:59 -0700 (PDT)
Date:   Thu, 30 Jun 2022 13:01:56 +0300
From:   Cengiz Can <cengiz.can@canonical.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Wondering the reason why __fput_sync is not exported as GPL only
Message-ID: <Yr10lO4vDLiqwLX6@nexusd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Alexander!

While backporting a few commits from stable to ubuntu distro kernel, 
I noticed that `__fput_sync` in `fs/file_table.c` is exported as
EXPORT_SYMBOL rather than EXPORT_SYMBOL_GPL.

Since I don't know the details, I wanted to ask if you know why.

There are certain OOT patches, in circulation, that export this as _GPL
and I'm not sure if I can convert this export to non-GPL whenever it was
exported as GPL only.

Thank you in advance.

Cengiz Can


