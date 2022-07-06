Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0070E569177
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 20:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbiGFSMo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jul 2022 14:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbiGFSM0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:12:26 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7C329C89
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Jul 2022 11:12:24 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id g20-20020a17090a579400b001ed52939d72so16531482pji.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Jul 2022 11:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=h0ZslgqQ94UM3iGDYCZGEx8ZwvbYHY5ZrQARiO/Kpbc=;
        b=mN3P8hPLWEZdYq/Iq2iVxFahPajjklJmxF0PKn78//uClSCt4VG2U88hiC+11v16xh
         y1SqfQca+JNBVAZI3ePM63ZbF/Ll2WyFBxkuWhi0DbjFZD7bQcGvjfRIWz9nOeUbfrNN
         Hn12zBv/BHEjrzhK9FyYZgJ+0yDe9gXNRwyhqCay9zO0NttAB/+uaRHDNofm5fJJ4uyL
         UE2EskqpdPqCBWA33nmN+zOjdnlOoGQz4kYyfy27QOsJGqWsEfVgJUCLFJ7tUYFz1it3
         polGmHqOxVGn/C/jOAMwwxKSSJA7dpPm8rxHhFZfT3QwVHikUfVhjEQAyBYj6En6JhiK
         ztug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=h0ZslgqQ94UM3iGDYCZGEx8ZwvbYHY5ZrQARiO/Kpbc=;
        b=54lsnx+9ETWe4UFf0UYDFEibteYkesfsVfFaZN917fv4Mw/T0URLAZQ+EJWnwOFyl7
         mabJY+daIHui2+Rrr6d8XufGwtxw/MWHoi28xdd5AWARXamr/JU82e0AfOz3FDInssra
         8yRMqddueXEyaU+M8Y8i4ivvaV2FSi7JlHMDshPf2zDnJTv6JGV+I1Exi1elZ1Rkh2SP
         Y8vbYKHrLZMhxy6cMKMoRYR7U+cKzSV/gE3BHE50yIqk6EzN0f+lGwgpWv4upJfPdLxV
         OJbyYPfMR+0SvnW6wlWB27hUej2rsFvS6EW03+mR4mYsFlsU8pRbmQcfBMk5hDbTdwMv
         hKrQ==
X-Gm-Message-State: AJIora9oTG0+DrHDRMCTcwM7wkai6b2v1+zVvg1E695Fp2Y/pHMo8Bp/
        0wDJRwyAdn2nnYYNTsZcSnkuQzDiDUR/DfPvn04=
X-Google-Smtp-Source: AGRyM1tSYQD1ua0CTRUtypz3YJM8n3hdcH3c6IIFHPkFLrrLRVN/+BPxkQjsmeSTaVke5NPWeFiSOZZnJAKztGQjykw=
X-Received: by 2002:a17:903:22c7:b0:16b:fa15:63d4 with SMTP id
 y7-20020a17090322c700b0016bfa1563d4mr7832109plg.2.1657131143717; Wed, 06 Jul
 2022 11:12:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a11:688:b0:2b8:44d7:af7d with HTTP; Wed, 6 Jul 2022
 11:12:23 -0700 (PDT)
Reply-To: lilywilliam989@gmail.com
From:   Lily William <sidimadi424@gmail.com>
Date:   Wed, 6 Jul 2022 10:12:23 -0800
Message-ID: <CAMKkZLv4y_z0FHKzrstmY9iWS6F=dqe-=gTuDKKGrJQyOX5=9w@mail.gmail.com>
Subject: Hi Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dear,

My name is Dr Lily William from the United States.I am a French and
American nationality (dual) living in the U.S and sometimes in France
for Work Purpose.

I hope you consider my friend request. I will share some of my pics
and more details about myself when I get your response.

Thanks

With love
Lily
