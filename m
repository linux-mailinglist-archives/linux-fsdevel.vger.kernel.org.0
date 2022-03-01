Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200644C8441
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 07:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbiCAGnr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 01:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiCAGnq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 01:43:46 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFAE4924A
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 22:43:04 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id s1so20609218edd.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 22:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8IqwMuZ8fxt+QmrdqHOlImG77CSzeOXAfU3F7s/g1es=;
        b=Zt7ADjjg4rQdQMZupIjoQnW8OZzkrW1QqynxdshmIEkct/PUWuc8mHmtaLMl7SRf4j
         O/SsyFxp+cXtdodgFZY1yMgZ2bgTQgu4U8POD6AExh1V8MJIq3bb7qef796sT4BUC6Vq
         2dGy0L5SzrT/5p9DN1SjVbc8UkJUnWYEDpsOv6Fszv3rzZ728aXUFTHimB0CAxkBX4DX
         xrufVPSLR9vwBy1h/CSAOqSR+pgCZyQ+7DUcXmZjFeG9I0KcBRC82y7KxWo00HF556jR
         M4UWSK1tWyrR/CgjgF6TF8QOCgtuVLdDxoUX7rPxIEp1+gTuWTERDx1fKUxHvoWeI9qA
         5XoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8IqwMuZ8fxt+QmrdqHOlImG77CSzeOXAfU3F7s/g1es=;
        b=e7a3dn7AQzwH/JFimyTbBJpk2gLL7QcSDTZZapT28zJChXpbouSylK16BXgkStcexx
         9RfLUau7A+s9wYwMQgHWqGe/KwTwKsgCHvP+L9XRHxUS6971TJZ8MMf3Dx6HUJmmeMYy
         vLpBU7onIxyXOKLVTok+q9UqPoQ+I+AGekWgPWT0KD9TfpZv+MXt5gZz/Jr8qNZ+zy+q
         A2BDfqgOjFP+sLYjlaBCN3VJBZcvr3/dhf82oqE9Uabm2NHpk6M7fNQC3fl8sKCZ54a8
         vJTGRDXRpA01zc3JS5M2i8+f4HsfrM7z0lyNfwPM0ZadCZTknQRJ9mwdSKfjoH919iim
         fr2Q==
X-Gm-Message-State: AOAM5324q1OhOAlgTxpCkPBQg2XfYW0q2bc3XxRNHSbQFM4YmQT7V2Bw
        tsMM6MYZTHyMJvF3CYTB4l6tlCjKrg50AaGXnpn0/qzksCL3Cw==
X-Google-Smtp-Source: ABdhPJzgEhCVEPSEh42pl5bgolf24c2VjNrVdrJH7yCpF+rJiuGUvKUvHAmfssDpqzWoeXIVZ0eqJZpsefLLCWPpQLc=
X-Received: by 2002:a05:6402:375:b0:404:c2be:3b8c with SMTP id
 s21-20020a056402037500b00404c2be3b8cmr22490537edw.247.1646116983110; Mon, 28
 Feb 2022 22:43:03 -0800 (PST)
MIME-Version: 1.0
References: <20220224054332.1852813-1-keescook@chromium.org>
 <CAGS_qxp8cjG5jCX-7ziqHcy2gq_MqL8kU01-joFD_W9iPG08EA@mail.gmail.com>
 <202202232208.B416701@keescook> <20220224091550.2b7e8784@gandalf.local.home>
 <CAGS_qxoXXkp2rVGrwa4h7bem-sgHikpMufrPXQaSzOW2N==tQw@mail.gmail.com> <20220228232131.4b9cee32@rorschach.local.home>
In-Reply-To: <20220228232131.4b9cee32@rorschach.local.home>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 28 Feb 2022 22:42:51 -0800
Message-ID: <CAGS_qxprS1e_f_K6bi-RvVESoPJ2yQgQVszcmcRFq_VQWduyAA@mail.gmail.com>
Subject: Re: [PATCH] binfmt_elf: Introduce KUnit test
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>,
        David Gow <davidgow@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?B?TWFnbnVzIEdyb8Of?= <magnus.gross@rwth-aachen.de>,
        kunit-dev@googlegroups.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 28, 2022 at 8:21 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 28 Feb 2022 17:48:27 -0800
> Daniel Latypov <dlatypov@google.com> wrote:
>
> > He also prototyped a more intrusive alternative to using ftrace and
> > kernel livepatch since they don't work on all arches, like UML.
>
> Perhaps instead of working on a intrusive alternative on archs that do
> not support live kernel patching, implement live kernel patching on
> those archs! ;-)
>
> It's probably the same amount of work. Well, really, you only need to
> implement the klp_arch_set_pc(fregs, new_function); part.

Yeah, that's the only bit we'd need to get working.
I called this out in "Open questions:" bit on
https://kunit-review.googlesource.com/c/linux/+/5109

As for the amount of work, I know how to do KUnit-y things, I have no
idea how to do livepatch things :)
Also, we're not aiming for something as "magic" as the ftrace one.

David's patch is here: https://kunit-review.googlesource.com/c/linux/+/5129
Here's a snippet from the example in that one:

static int add_one(int i)
{
/* This will trigger the stub if active. */
KUNIT_TRIGGER_STATIC_STUB(add_one, i);

return i + 1;
}

i.e. users just add this one macro in with <func> and <args>.
It internally expands to roughly

  if (<check if current test has registered a replacement>)
      <invoke replacement with <args>

So it's all quite simple.

But it'd definitely be interesting to try and get klp_arch_set_pc()
working on UML if that's a possibility!
Speaking from ignorance, I can see this either being somewhat simple
or very painful.

>
> -- Steve
