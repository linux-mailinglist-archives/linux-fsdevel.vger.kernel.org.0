Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E0E6B088B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 14:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjCHNYF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 08:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjCHNXk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:23:40 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA550BD4FA
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Mar 2023 05:20:18 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id k199so14561885ybf.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Mar 2023 05:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678281618;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zv+/okQpvLPeEesFbW+f0IeMoL7WJaBwrI7ka3EB5Nc=;
        b=beriZHac6z4sRNuFTm2+2QYEXbIFUb4q/rbgaJ3tZqMIW4zP4bOZ5DQrvFc4lm6pUF
         xQL4eEq+T0XForJBaAh5ORO71ZKrrr0K9FQXebh7usMSgRvhlpewgFxoMkShgWWZlV1o
         Hi+9mZOJV723oQjtI573i5+wsoql5BsqVrEiEOlN+8AFMjdy1sQFHO8SJClwKWSGP9+6
         LT+pD32gmJnsqHcJPvKhvJjtn5NchOsjsjh7AJ8VIxX5hKC6DkENcrPFj2+NTTxeyVLf
         p6asUoXcogkiSXDXuEikKoFsvxN2EpQfk17U5M2AUnuIV1m6xK1KVY0v7zrG9N/fLCjH
         wl0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678281618;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zv+/okQpvLPeEesFbW+f0IeMoL7WJaBwrI7ka3EB5Nc=;
        b=HXYhbOK1gXLSQsIbvihRV92hB5N89SSps10Q0QM67NTDC7l994t+MXNlWeiag1GKnL
         EFN3P2guSB+JA6uvxOYUMFAJmKkLjyqtJj+m/ulVYREAnTRRuayQvxeTY3gwXQKWhKGU
         ItRSh9eTquyYKORdHZGULgBtu2k6dKMP/NzVYKvUwurS/3DZlkNng3iwzyNUwIUxTIcx
         7AkOw2h7n1cyOY7SOvMEfuVbptBQJn0KbcrFVEEHesphAlxBfEHrgt1rH+nXigyvDWh9
         VcWg7AFsPY9hqEUtE0tvI46vJSseIkYCV2bQckzAh1GEC1w/WvgA+vxT4ed0eaBc+v7m
         eCew==
X-Gm-Message-State: AO0yUKVUHW8z9fjg7pPEm2bhTl0M4JFK1dl9n5aa8JDoiD2H/FoiHKxC
        Hqw1q+Lf+cuux2cHNs3AKJXj+hOm5qfZqfWplbY=
X-Google-Smtp-Source: AK7set/heTYVNBn5i71EAPpc5T95TpPXKzleBhckLxSAiHeqmVL71F/wzaAmLIqfIDBp1FB94DiUKOFFD2iG19+F+f0=
X-Received: by 2002:a25:8b03:0:b0:ad2:3839:f49 with SMTP id
 i3-20020a258b03000000b00ad238390f49mr11103591ybl.5.1678281617980; Wed, 08 Mar
 2023 05:20:17 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7000:915d:b0:47d:3f52:35f1 with HTTP; Wed, 8 Mar 2023
 05:20:17 -0800 (PST)
Reply-To: au12bello@yahoo.com
From:   audu bello <essj7302@gmail.com>
Date:   Wed, 8 Mar 2023 14:20:17 +0100
Message-ID: <CAC2u7wastjEJeB9L2gBGqQ_pQh+4A-qKX0kSYYZpzTw=RFFtFg@mail.gmail.com>
Subject: I haven't heard back
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.0 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b35 listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8890]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [essj7302[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [essj7302[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

-- 
I've reached out a couple times, but I haven't heard back. I'd
appreciate a response to my email about pending transaction
