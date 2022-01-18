Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94DCC49222C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 10:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345333AbiARJHQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 04:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345303AbiARJHJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 04:07:09 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D2DC06173E
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jan 2022 01:07:08 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id m8-20020a9d4c88000000b00592bae7944bso20159347otf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jan 2022 01:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=AIHedDQeQ2nfeFyhlIY6iBZ7Eo/kAlP72EhStgPHV1I=;
        b=MwuXI9bo/bHhmwSiZow429zo8aSB+O2GLUej+IgcXI5RO/o3AqH4CSQ9NAWjmHtI2V
         CWHWHodvspT0TuHM5gPO3+DsIPBfj5I7xK86tBODXNXUNaTSYWM44YSISAFFoUBCT0Gg
         kUseC6gV2vHxvawS1hqRt36sr5ZHyfG2404GVbLMHZFIWJloN2l0uLLpE9xGpmX+gvFt
         T/SKBR85N56dXCUtLtefGn/VyQ5YHcl7r/PL/CN8dJjeVXQr6S8XtfLgDxWiWVeFp/uz
         rUPQ/vWjjy9uE0DFDcQNAXccnZrg9yq5ahPtbYdtOe2x2ilhAjqIuZxj1Am01Jk0eYRx
         TdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=AIHedDQeQ2nfeFyhlIY6iBZ7Eo/kAlP72EhStgPHV1I=;
        b=c6tzr8JzkZi/R9ueXdyF2dMviYws2cIJq48bYCcmfRAurvnEyFsQP5d5vmbJKmCqaU
         VBROuxLSTE8bMxnUqOnMZXzfgGn/XGi1TNDvhPwbgJxCqkHmQiutfRx2h5++gKqR+gvg
         cYQMdhx7RbgEAV3mQQtnveH3t55klhoVMcJomX9Pr0BNI654FnN5tuWJOzh+sNJQsM9Z
         UYPNf4FsT//TQ5U/ZmFwSR9g40t8AA2DnpQGhBv1KkCW/X2cDbW2Eh/rC80soUzYSgV/
         68H6iYlR0zZHgJX5OF9G+qMLwezbPj1w/sbl60oDX2ocqyYiq6/+1H74ySn3p7CrvvYu
         1enQ==
X-Gm-Message-State: AOAM5313+HxV1OXZNHqdYVfg/VcKLsomm8RZqhSbIadJrqBMCoap5dgh
        WiWQFUoU6HD9BitX3T3rIzDIYEZseFEKLUAseiJPTiTfrdTEFA==
X-Google-Smtp-Source: ABdhPJxA0wzoWLcZT1OxNrAcI8XNQh1NLzUcYEY6tZP9fJ+XZhak2v8hM5rDGFWcpfNwqZAdykwmchO/6gc3Jodrd8o=
X-Received: by 2002:a25:bb49:: with SMTP id b9mr31607636ybk.0.1642496817798;
 Tue, 18 Jan 2022 01:06:57 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7108:3655:0:0:0:0 with HTTP; Tue, 18 Jan 2022 01:06:57
 -0800 (PST)
Reply-To: asil.ajwad@gmail.com
From:   Asil Ajwad <graceyaogokamboule@gmail.com>
Date:   Mon, 17 Jan 2022 21:06:57 -1200
Message-ID: <CA+Yy_gCScGafLu0JmRT2o26eNt1J5S_DUo_G2xwuVh0p3r+Daw@mail.gmail.com>
Subject: Greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

-- 
Greetings,

I am Mr.Asil Ajwad, I work with United Bank of Africa, can you use
an ATM Visa Card to withdraw money at, ATM Cash Machine in your
country, if yes I want to transfer abounded fund the sum of $10.5million
US-Dollars, to you from my country, this is part of the money that was
abounded by our late old client a politician who unfortunately lost
his life and was forced out of power Du to his greedy act, the bank will

change the account details to your name, and apply for a Visa Card
with your details, the Visa Card will be send to you, and you can be
withdrawing money with it always, whatever any amount you withdraw
daily, you will send 60% to me and you will take 40%, the Visa Card
and the bank account will be on your name, I will be waiting for your
response for more details, thanks to you a lot for giving me your time.

regards,
Mr.Asil Ajwad.
