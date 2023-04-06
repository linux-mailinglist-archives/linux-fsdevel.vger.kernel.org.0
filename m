Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8416D974A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 14:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238049AbjDFMsq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 08:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238028AbjDFMsb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 08:48:31 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9415A11C
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Apr 2023 05:48:30 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id 11so1092007ejw.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Apr 2023 05:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680785309;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=YdecW/K96+bdpJcZkif7ZCzyRdkcOkisznpyQ1RbMLR1rkZA4CqfHI2z3SSKf3gL3U
         oQsB3VQ6/M7FdzCFHubah1WyVGCE0CNugattZMst/8b9lbqTho47z0HfCwppcNi878T0
         UmKZrynxouuJtKNfvQSaMpZrVyJ57jjiuo3lBUeR8cRbvoknwXveZnMSihkBrcPP4MH0
         CVS0kmiZaCxH9Xq/kb8X34X/NLJwFxI6QOcVA5ipER8GOtvzgVrmkP/0X5Hzbl27XuCG
         9v1L7qv4bD8w9yOY/OQ3d/gH6aUxW6m3kvhdOmugoa4wVbFi5KieZCxCMV7+Ggr3km+a
         TUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680785309;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=UqpT8wBy5GU6OZorZ+knR/s3AwMtVscT4TlO9k0VSI6XQhuZSdJxSgBL8dcHXh9snQ
         PeCO9/9qaWEqxh/QpCohOmTQAENiN5Jdz1TZfCNW6BWS2p5aHVewqzojHspektnXsLot
         HNSNuRoa1AN/DMBD1EGiYVX9uyaVaJLZAgj+kjX7AvmmQFhIS0JtxLsgRZZS6i761o/8
         ceP7ScsoipzZcqWERI2H5IG6JTUKwbxR6BgEzvYRqfUcM1HqpBw40xV7K2QTGxjbYCUe
         vqXFI21rTZi7KjjdgL/teCRlyf7i5NUjQX4zRndjOEFb4TxkIlOTrzvSiIhVcfM7I+Xv
         80qg==
X-Gm-Message-State: AAQBX9fv9A9wCed7XNBXx8QRp7HkKHZZtDU/Z/7kuoz6ta3UlRG6aci4
        KbFNwt6F68F6kxkBYkwH1XcGLjgj/s4p8Qko0p0=
X-Google-Smtp-Source: AKy350bm4e6NWZ6Lj+cO6GDm6JCIkm0Gi+0C+MEJZN0vY431A2hAHOUtKU1jBn4bcU9VPsaUNUgBEf7bBU9vO4878hU=
X-Received: by 2002:a17:907:6d0e:b0:8b1:38d6:9853 with SMTP id
 sa14-20020a1709076d0e00b008b138d69853mr3273654ejc.2.1680785308720; Thu, 06
 Apr 2023 05:48:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6f02:a39d:b0:4b:3a4b:8eb6 with HTTP; Thu, 6 Apr 2023
 05:48:28 -0700 (PDT)
Reply-To: dravasmith27@gmail.com
From:   Dr Ava Smith <haku49998@gmail.com>
Date:   Thu, 6 Apr 2023 05:48:28 -0700
Message-ID: <CAOXV1D7UGgFwE71j1656wC1D8poPaW+WK4a4xcJ_w1tQNXV=sw@mail.gmail.com>
Subject: GREETINGS FROM DR AVA SMITH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

-- 
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
