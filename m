Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B3752FA23
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 May 2022 11:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbiEUJBs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 May 2022 05:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiEUJBr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 May 2022 05:01:47 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E973F980A6
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 May 2022 02:01:45 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id m1so9473505qkn.10
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 May 2022 02:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=SUWQMmwZSct1NUq5pHL/uGOr0m/f9iWjJQkP63QJuAY=;
        b=Ha+MZHXwll61BrfP97EXkY0HJkcJNFQ78sC6U0pnBKZ+hSnKS+K1JqFkiL1wzIl6nL
         jFnIsjJTP3gkUtffyhEzxuTfq79G2JWca/82bSeAiYTlXCjwun2j3ZgIUgyFzlgMUgNs
         WWkOl1N6GFs3+sotkrSpSlsxxJKdHTomOgISPyknShNh8mcfIRg6/0fwmyXTr8s01XJj
         PneEIcguOAFnwL+pN2J2DoWGVVXWmoKurlR/XwjS9NJxolOSixyK4I3Bz47DARVcgRh/
         4lDM/jHwu9+PPBR1D2t+4/LYfC0Bkspr6/IsxUgzguuB3+fZTO05rIUneb4I3+Hrzj3u
         1J/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=SUWQMmwZSct1NUq5pHL/uGOr0m/f9iWjJQkP63QJuAY=;
        b=WAz2/K/BTXWB27+iUkj5YVrk6dTJIkQwbv+HuvEtTH9wglTdCKi0QIv/Bxe1tOoL4h
         uykJ7kRmS9+GSAg0hA+wKvT0yNddZozYgt7M45BfssupHHL1vWQCBViH6tVFwWgVB+Ik
         Gixp3ixJrF9P6iQIALXRnN08cjS3mXffkTVQ30sZs7B+WQTKLK9flTWdVqADOEOAqusH
         YOOxRVa18XjjSLrJnO7bnWHwHpI/0XgoRK2h4HHQffpDwdV8TpClXlrsvfy/0enzhK2V
         sYpqGzkPalA8jcEbDyjem1ceasldxsFG/f07KdqHtdshe/gximrUKS6133VOWNu46n0m
         LRpQ==
X-Gm-Message-State: AOAM530UiG+XQw3MCjG0dIdXbqrdAOPsWngsFTbYttlTDl8nxe6BEPLi
        NUb7WD6rFqiNI+K6TGdC05osZFT8MpZAXL8eD3qku03jdQQ87w==
X-Google-Smtp-Source: ABdhPJxElHOPDd2lORmUckZFaNpwB/mljkT4mDA0ipuEF7Lpoe4wk8C+fX/H1XEsFif6jGnLTktsejWXViVYUXNAWlM=
X-Received: by 2002:a05:620a:254c:b0:6a2:e7dc:25e3 with SMTP id
 s12-20020a05620a254c00b006a2e7dc25e3mr8321894qko.63.1653123704933; Sat, 21
 May 2022 02:01:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:5b05:0:0:0:0:0 with HTTP; Sat, 21 May 2022 02:01:44
 -0700 (PDT)
Reply-To: jub47823@gmail.com
From:   Julian Bikram <senyokomiadonko@gmail.com>
Date:   Sat, 21 May 2022 09:01:44 +0000
Message-ID: <CAEdpTfQMKdx44vJqY5hU3=v1mKyL33pq0fRWUkZ4Up-+g4EtVA@mail.gmail.com>
Subject: Please can i have your attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:72c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4958]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [jub47823[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [senyokomiadonko[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.4 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear ,


Please can I have your attention and possibly help me for humanity's
sake please. I am writing this message with a heavy heart filled with
sorrows and sadness.

Please if you can respond, i have an issue that i will be most
grateful if you could help me deal with it please.

Julian
