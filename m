Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F5E722E70
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 20:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbjFESQM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 14:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbjFESQL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 14:16:11 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC3C135
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 11:16:01 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6af6b6837acso3498756a34.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Jun 2023 11:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685988960; x=1688580960;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=lCCebxa6WkV3BTEVmv9XaVmQMtmrcMrpYgjDEqBTOlxeKOWNMJsesbk1qYb9APT9mZ
         Cw2TIGx4BZA+4ZIwZnj2kJnIyUXVETVepRuZ/zRXGE9ChMjlQpPsTLw346YIHzEGsp94
         aeUpJ1zarnTGxBMreOtc+M1M1boUgC+bss0zE5lxRvghA7UAeurUhy0caX0bB1+rIyra
         uMYbW9LVkfGm3XzWTObbVlInnPknvrMGjg9LGPg1uPFiMHbs8vQ14uoRpNFABJYwWck6
         yoruOWPqS8OATnaGSGJArMj68s6DDcohR1FNb146G7FFeCkI96ffzll7pMbrWIwZ1qes
         rl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685988960; x=1688580960;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=Co0Q8aDUcqqWzt0bANNbyCVTAAP/UZd+Vq+MVnkhy1LDgKpR62gMug036rh0vbSZeY
         Is2I6NjdhMwdvnbe3DMIU8jKHw2lfCCDtlXqdYpMkAycjKB48fdpujWgfJsFHin1M0RY
         Tck8Up0pL0rr8v6IJ5MQGvTUtiwhVvEYuff9xQMF+Ff42jnORTIrOCtBz40bFzj78PE1
         cG5Ox76HWMfukHio3cceSbs4J9sC1QA0UySZ0je60rzgrJMiZ22PuDOqAXSREe3Roerj
         YBL+bILzwFecWNuCR1ta5lepAZKrXF+izBLPPx3aJpj5Li2+hjxKtHz3JqoQ76uBhCe0
         FDJA==
X-Gm-Message-State: AC+VfDzLM8GJGi/vcbzW38qZ0KbgHhp9IKO5dRh8S9GciqBEhh6l1xjb
        93nlLBF9+Xs9B0GPSBgalpkF+TUloPSosWGMd9k=
X-Google-Smtp-Source: ACHHUZ7z6Gw1niWErGg9pxRDHsSzF0L8SGuHfYrS2KGCk7rh5y2rHWYdYYtYbaYnH3pUIPy5Z0lXkKZzwV2bJ1dZfn0=
X-Received: by 2002:a05:6870:9204:b0:199:f985:7129 with SMTP id
 e4-20020a056870920400b00199f9857129mr447323oaf.39.1685988960368; Mon, 05 Jun
 2023 11:16:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:6f93:b0:127:9fab:a046 with HTTP; Mon, 5 Jun 2023
 11:15:59 -0700 (PDT)
Reply-To: dravasmith27@gmail.com
From:   Dr Ava Smith <raqsacrx@gmail.com>
Date:   Mon, 5 Jun 2023 11:15:59 -0700
Message-ID: <CAP7=Wk7aFG+1KeNCvCo0vwU5FQLDDaFd-8ZRsNF2gT=fzOjpSQ@mail.gmail.com>
Subject: GREETINGS FROM DR AVA SMITH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:32c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dravasmith27[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [raqsacrx[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
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
