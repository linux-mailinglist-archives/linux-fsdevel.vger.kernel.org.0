Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA347A6019
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 12:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjISKtY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 06:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbjISKtL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:49:11 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F7D12C
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 03:48:42 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bfc1d8f2d2so65577901fa.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 03:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695120520; x=1695725320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQr4Sx1ldvXNZ6IOlKUpv1voioV1QPvDiIqX+NeDLAs=;
        b=PHvM6Hqh5YgvdWJSK0Fcbx0F2+bC2le8CPkiHxXteeQkn4XDFa/J+TcGkQh6/07fjg
         bog1lC/UhFV6tJxQYWQTyfEaO1+eYBzYD2uHPpP80OQGvQJTgVjzl5KUdLyUq9YhaDtW
         tNJjIoO0Fr6LocrPBA0DV15wYfRlTclh4DpdBx0HzGr/6xSRey/ktye+GoWdPcL51N8N
         ylGtIo2WUbpZxnDJBr3SeNTSaCHCHVPH2dffVPt451i3WIVeedcsE2gRqcg0ZOMmgYGs
         26Ix6HJXLtfT2rtxDws7fpPh/KEebcFW7hfNNek7nU/snpkJAsa2ZuzApJvLfWfTCFjh
         PCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695120520; x=1695725320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQr4Sx1ldvXNZ6IOlKUpv1voioV1QPvDiIqX+NeDLAs=;
        b=Ln8dWmTCN4sbNFPw4SlF6mYarVU9KHtE2LTpoOh4zWCGoa3WoT623s+VwnU98MVuia
         JfWV3U8ZyrBskpow2xT2ML3+aUzA6b7G+Zsnzv7ZgCoKIQJgw1G60CMD9t3Z9Wq8oACg
         AIHDB8+RGFpoRfWCDhAZi9m5if0LqRaGg+fxMjVDbHsePTtLf0XSYCLLxj4+2+9H1sq7
         MEKxYL0936s8UGyPgWilpcHOUG/KFepjnwbjBQmKRazQpi5mBs99uE49aQPk1zI5UvsF
         xatQC/NswpFvN8JflmXJ159/E+a/hvKsnKEgk68ishD+dBIm+Wmy9213HeJuSWdsKWkQ
         Q9mA==
X-Gm-Message-State: AOJu0Yy4GRwnem1nwFgDqUglI/Y8ClNPkVIsAqAv0Q+g7TgFnIsxUwZP
        2eGaGiXJ/gs5hrrsoBpRKHZPYF3uZ5gyv4rHeT3zd8vfL4tnTBwnq+ALmA==
X-Google-Smtp-Source: AGHT+IHbv5+NDMxFHj8J3NjS7iXGg/0J2U6csG/Lj+jokD8KjCv/Mv/6rckt/ZQcf+23ilnFNcExh4caEtknjUpEIi0=
X-Received: by 2002:a2e:9d45:0:b0:2bf:af0c:f695 with SMTP id
 y5-20020a2e9d45000000b002bfaf0cf695mr858232ljj.22.1695120520250; Tue, 19 Sep
 2023 03:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230918123217.932179-1-max.kellermann@ionos.com>
 <20230918123217.932179-3-max.kellermann@ionos.com> <20230918124050.hzbgpci42illkcec@quack3>
 <CAKPOu+-Nx_cvBZNox63R1ah76wQp6eH4RLah0O5mDaLo9h60ww@mail.gmail.com>
 <20230918142319.kvzc3lcpn5n2ty6g@quack3> <CAOQ4uxic7C5skHv4d+Gek_uokRL8sgUegTusiGkwAY4dSSADYQ@mail.gmail.com>
 <CAOQ4uxjzf6NeoCaTrx_X0yZ0nMEWcQC_gq3M-j3jS+CuUTskSA@mail.gmail.com>
 <CAOQ4uxjkL+QEM+rkSOLahLebwXV66TwyxQhRj9xksnim5F-HFw@mail.gmail.com>
 <CAKPOu+_s8O=kfS1xq-cYGDcOD48oqukbsSA3tJT60FxC2eNWDw@mail.gmail.com>
 <20230919100112.nlb2t4nm46wmugc2@quack3> <CAOQ4uxgBXBuZ4PZkL7WWCfT699Ck=jbnxk-e-ZFwe=Ys_p_urw@mail.gmail.com>
In-Reply-To: <CAOQ4uxgBXBuZ4PZkL7WWCfT699Ck=jbnxk-e-ZFwe=Ys_p_urw@mail.gmail.com>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Tue, 19 Sep 2023 12:48:29 +0200
Message-ID: <CAKPOu+9N5kJ317dJPBjn1E+sZbHPeXvjf1qEwHvE1q52dG5EeQ@mail.gmail.com>
Subject: Re: inotify maintenance status
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Ivan Babrou <ivan@cloudflare.com>,
        Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 12:42=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
> Those cases are demonstrated in the --filesystem functionality of the
> pull request above, which handles "dynamic watches" instead of
> having to setup watches recursively on all subdirs.

The whole-filesystem mode is certainly the most interesting fanotify
feature, and the lack of it the greatest weakness of inotify - but
API-wise, it could have been implemented as a new "mask" flag in
inotify_add_watch() with no extra API complexity. That still doesn't
justify the huge complexity of fanotify.
