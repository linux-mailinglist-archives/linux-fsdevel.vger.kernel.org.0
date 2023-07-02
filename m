Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9927745304
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 01:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjGBXD6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Jul 2023 19:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGBXD5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Jul 2023 19:03:57 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5129D
        for <linux-fsdevel@vger.kernel.org>; Sun,  2 Jul 2023 16:03:56 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fba545d743so51737905e9.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Jul 2023 16:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688339033; x=1690931033;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6gpw50arjJAJYutxnBYI251PZ1iO12jHMUjWqVshAjU=;
        b=Xl/PsZg4dDTi188TwPGfFyMiVXSKbfvI09ZuDbf1rcKV9uHl2Gk27HnDytkNmy1cTJ
         J1ykZ4k+3wzJctxfyFo7/ZuUbzYBDOPr9LyPigEWRXg1GwqcMkHg6ey2D86EdkJjM6/o
         VPbzlFN5MWlhxaZkpJttUf4p77uZu2prpIgvQjPmeaE+qPRhpu81NLBCv7V3yZzeYlyw
         s2hkATn4rqCI0dNVVzBemWaB/89NbpJd5847wfWtWe//TEnJCr+UvCaoDXlyjqs+1zjo
         f3mG6KMElJeJt6uV4d47lTFwInVu8NkcA0DZNmPmEU6uP8jzXHuaKov33z7smCkZR4ZT
         YKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688339033; x=1690931033;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6gpw50arjJAJYutxnBYI251PZ1iO12jHMUjWqVshAjU=;
        b=bmK4EFy944qPiy2U7pmOcLne1fdU28t0gzwNFYWfNN4Qt/GL1AqgaqLT6ELis9gYax
         +RJG+Jec5XPqBwvCYD6AGHDkvMBUXxlvioP7u8/dKFfK1DP/Q14wWt8YZBSrkjZfb2/Z
         6rw1zuJwdybB5kW6SnUzmE52xqdD7FFmmL2bk+r+UmKWFXx1kx7BTO7BQV2XDonE9ktb
         uCnEdJWKX3Hd7oWqSpd9mUuynjug80bEhabFQrvYQzLXjgNtvtLkx/epAEvW1RaKUAR3
         yUMM+FrjlsIzhCjopJt/r3KQkpqPwcI7Gk3NmgaxN+uOOWI03bNIETsyOvHxvdQgCRdK
         +7qQ==
X-Gm-Message-State: AC+VfDy5P3T58zGVMTnWPbU08IGXyyvdvbKNkxYEf5JOL5qL+thAucT4
        1Ym3aZMvShUngT3wQNv9dIbS/7E87wY8e1TPJDg=
X-Google-Smtp-Source: ACHHUZ70axP5ThfsceJmQzuUG4XIP7xVQ0H07UY9KxFYEKFHl3BSQbPAEg7IWIpKJjVkbn7iZd6IbCb1HSx8DPV1PrI=
X-Received: by 2002:a05:600c:3799:b0:3fa:9890:8016 with SMTP id
 o25-20020a05600c379900b003fa98908016mr8051187wmr.2.1688339033409; Sun, 02 Jul
 2023 16:03:53 -0700 (PDT)
MIME-Version: 1.0
From:   Nogay Adygman <nogay.adyge@gmail.com>
Date:   Mon, 3 Jul 2023 02:03:42 +0300
Message-ID: <CAFUOiQauO_NBe2Ydq4JVTgk5ZSO1nwW1-xOT694PmQJG7ArcJA@mail.gmail.com>
Subject: rasist - kandidat (+history material)
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

https://de.wikipedia.org/wiki/Alexei_Anatoljewitsch_Nawalny

(+ no work link
http://lezgi-yar.ru/news/navalnyj_razreshit_gej_parady_i_zapretit_lezginku_esli_stanet_mehrom/2013-08-24-1620)

https://flnka.ru/digest-analytics/5673-kto-podstavil-kreml.html

aborigen nogai
https://www.interfax-russia.ru/south-and-north-caucasus/news/vostochnye-rayony-stavropolya-nuzhdayutsya-v-pritoke-naseleniya-v-tom-chisle-za-schet-ukrainskih-bezhencev-senator

interes monument
http://zapravakbr.com/index.php/analitik/1498-madina-khakuasheva-chto-skryvayut-geroicheskie-pamyatniki
