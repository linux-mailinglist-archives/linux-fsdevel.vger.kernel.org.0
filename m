Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5EC515FEA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Apr 2022 20:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238997AbiD3S5a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Apr 2022 14:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238070AbiD3S53 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Apr 2022 14:57:29 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B516AA68
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Apr 2022 11:54:06 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id x8so2212422vsg.11
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Apr 2022 11:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=XctSZ3JEGJzg17YhmSqbRN+ybneIXet1xf2900QMGwY=;
        b=M7uqOBHzUA8fFZkG1kz5VnGbAk4QP8RU3G7Dw6HqKLse47PxH+X8goS1qvXYZ2aw7J
         GQ+jjXAA1UggzOMzDgzTOepTf0ZLoJzt9gc8oUGS+Bt433Mt7cm3C9Pd+zY4QS2jzoMy
         zYkQ7oiQlcl6WtpXdRuzi3fPp/hKDG8RI4LbWgR8eCPUa7dz5hSUkRP95ApUP1UCKVrW
         9Ir9d7dCdkG5R8hkFc9ipsMczkEQ9jOlN8sw05c3/c6EbtdjJfOHAMXmeoP39sEhnVaW
         jjYSFoutM5xy4FhJVQF2xextgARPM9V94/6WN+ddaGuLskP0X9rCKZw76Ki896oz9jpO
         4GJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=XctSZ3JEGJzg17YhmSqbRN+ybneIXet1xf2900QMGwY=;
        b=ybGDIaPZq/30SDMehOQl1C5eS8gVQcY+plrLx/H6WUxAvdPzBTEoYniALecwrnvUSD
         ciI59/fmb6+TTpGnyqtMqAOBDTVYzTr3thX7xGulszlVwcQ1OedKDQupnEHdJP9pw3n4
         st0N1gSgK1eUdd+4dApxWZpSgtxnRArI+r1i7vJfakB6Sh3rqMRIbyx4+HyOci7wQ5G/
         T/12CJSH3XWjYnsWeK8uxO9zftI7NLXoAciWayp4wjekTdhWJ2V0FfPkJSttB/o848yM
         qrFljBl2f2cdx/r3CcDmXqaxCUKI4Ea57yPqTfTFte1ax8JlcqSrr+TWTK7EHEGk1IwD
         u47Q==
X-Gm-Message-State: AOAM530BZngnPS5OEn2/N+HjyAXFIljECWk6jHqSMl9jVvHSLoC9eg+J
        nhbMSNnUdIeIehdLyI4v6kAeChzmhb4l6Vd8nUo=
X-Google-Smtp-Source: ABdhPJzSAMC4bpdaqycvltZDv6vOeH1F4s8T5kMSs7EHRsaUzfvxucKHD0gDH2a2i217V2btqTE9PqLy+I5g+btPjCs=
X-Received: by 2002:a67:ec48:0:b0:32c:e167:5d84 with SMTP id
 z8-20020a67ec48000000b0032ce1675d84mr1357245vso.73.1651344845203; Sat, 30 Apr
 2022 11:54:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:dc92:0:0:0:0:0 with HTTP; Sat, 30 Apr 2022 11:54:04
 -0700 (PDT)
Reply-To: sierraallen509@gmail.com
From:   Sierra Allen <christianpaige501@gmail.com>
Date:   Sat, 30 Apr 2022 11:54:04 -0700
Message-ID: <CAC4qU-ce9mALN5O7QZ9veqnsda+2iGtRMAf5Ps_r3+WZbi9Zuw@mail.gmail.com>
Subject: thank you
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e34 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [christianpaige501[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [christianpaige501[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [sierraallen509[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Greetings

I'm Miss Sierra Allen, it pleased me to contact you and am here in
search for an understanding person whom, i can trust and also take
as my beloved friend please if you are interested just write me back.

Yours Sincerely,
Miss Sierra.
