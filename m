Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C1655B2BA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jun 2022 17:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiFZP5P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jun 2022 11:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiFZP5O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jun 2022 11:57:14 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FABCCE24;
        Sun, 26 Jun 2022 08:57:13 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id x21so2644944uat.2;
        Sun, 26 Jun 2022 08:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ru8S1AO6bDBYdJVooFARcAR7lADQiG7CRLPBFOToc3Q=;
        b=bOThzj3P+GnaLEYcfbhAuHnTSM/DLtZeOo7iXx9TCX71UC1k6g3AtTNGd75iPYW8BO
         1inwM2doFEdK4ZbFwsZzK2fPmFqBeppg5ZSklLfGou3KTTIaqu6YB1v5nxBqYaQ2hncn
         zO0Xw5/qXMQ2DeK8ZNQRcPjB9CkMs+Tj+AwtGWOc4F51r38h+KoQWWYuhlNCNFW57IV2
         feb5FEt95+CoYkEeFYiKZc5g7bfPGhcLqpfPgM4R1zSNoew3jTR7f/QHOxx4aTdlea8o
         EaOtUGVAZFoH5orcGMjuSPSo28ncdwCUvrcs/9LoXj0pSmRAnlruNl2ZemGgIerrkPbM
         u0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ru8S1AO6bDBYdJVooFARcAR7lADQiG7CRLPBFOToc3Q=;
        b=nFUNSAQflO41xhhkNEpC4WbjSLLqWAz5NTRyjUFop6DWMMCTmPidhbcK2e99NmP1fv
         wHAb1Jl9WeahxhWs14DMOxj4qQXR0IuBUGWoKPbI86nYD+cc/jpp6tKP6MoL0JARxMAI
         T+/tb5/Vod3bW/Bats4dRHadQOTd4jlPJDWsVOCY3W1s73Av40BwIkW3R3DU5Imzwpn+
         A+ZMHzVWDscanJdiSQfr/X3WEZ8lbKXX7g8JliLMsJeCpKLkEkkwNtFfo6Injtjg6nzM
         5nWvXlm3qkbb+w2g69RgXc1LPG4gWXCL4ci10/INSdzEAvAxjO0gWFAQiv3VsS9sDcsf
         L0RA==
X-Gm-Message-State: AJIora8fsA6Vz6402m75SEXc2iM5tuEAA7EK+yRtvrTKNhUka5pWQn+J
        V1ik+lDwDKoPEczRQNoXuPJ9XmdIB3WxXrzs3WjiAA44Pp++Tg==
X-Google-Smtp-Source: AGRyM1tmiXJohlxVh3s42y0kiTjHO4IkXPlBFJrOCYgCzPbLRG3yUtbuDWgt2dYkiN71OjswS4HNxor7TjWLREZR3ZU=
X-Received: by 2002:a9f:23c2:0:b0:365:958:e807 with SMTP id
 60-20020a9f23c2000000b003650958e807mr3111764uao.114.1656259032521; Sun, 26
 Jun 2022 08:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220624143538.2500990-1-amir73il@gmail.com>
In-Reply-To: <20220624143538.2500990-1-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 26 Jun 2022 18:57:01 +0300
Message-ID: <CAOQ4uxj8CLbiOjwxZOK9jGM69suakdJtNp9=0b7W=ie4jGp3Sg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] New fanotify API for ignoring events
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
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

On Fri, Jun 24, 2022 at 5:35 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Hi Jan,
>
> As we discussed [1], here is the implementation of the new
> FAN_MARK_IGNORE API, to try and sort the historic mess of
> FAN_MARK_IGNORED_MASK.
>

Jan,

When we started talking about adding FAN_MARK_IGNORE
it was to address one specific flaw of FAN_MARK_IGNORED_MASK,
but after staring at the API for some time, I realized there are other
wrinkles with FAN_MARK_IGNORED_MASK that could be addressed
by a fresh new API.

I added more input validations following the EEXIST that you requested.
The new errors can be seen in the ERRORS section of the man page [3].
The new restrictions will reduce the size of the test matrix, but I did not
update the LTP tests [2] to check the new restrictions yet.

I do not plan to post v3 patches before improving the LTP tests,
but I wanted to send this heads up as an API proposal review.
The kernel commit that adds FAN_MARK_IGNORE [1] summarize the
new API restrictions as follows:

    The new behavior is non-downgradable.  After calling fanotify_mark() with
    FAN_MARK_IGNORE once, calling fanotify_mark() with FAN_MARK_IGNORED_MASK
    on the same object will return EEXIST error.

    Setting the event flags with FAN_MARK_IGNORE on a non-dir inode mark
    has no meaning and will return ENOTDIR error.

    The meaning of FAN_MARK_IGNORED_SURV_MODIFY is preserved with the new
    FAN_MARK_IGNORE flag, but with a few semantic differences:

    1. FAN_MARK_IGNORED_SURV_MODIFY is required for filesystem and mount
       marks and on an inode mark on a directory. Omitting this flag
       will return EINVAL or EISDIR error.

    2. An ignore mask on a non-directory inode that survives modify could
       never be downgraded to an ignore mask that does not survive modify.
       With new FAN_MARK_IGNORE semantics we make that rule explicit -
       trying to update a surviving ignore mask without the flag
       FAN_MARK_IGNORED_SURV_MODIFY will return EEXIST error.

    The conveniene macro FAN_MARK_IGNORE_SURV is added for
    (FAN_MARK_IGNORE | FAN_MARK_IGNORED_SURV_MODIFY), because the
    common case should use short constant names.

Comments and questions on the API changes are most welcome.
Suggestion for more restrictions as well.

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/fan_mark_ignore
[2] https://github.com/amir73il/ltp/commits/fan_mark_ignore
[3] https://github.com/amir73il/man-pages/commits/fan_mark_ignore
