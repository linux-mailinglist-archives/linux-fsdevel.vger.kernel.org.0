Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8968169D0CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 16:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjBTPmq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 10:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjBTPmp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 10:42:45 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BEA1EBF7;
        Mon, 20 Feb 2023 07:42:44 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id s26so6268661edw.11;
        Mon, 20 Feb 2023 07:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1e7qAtyTbXCYmyAw0z2FHUgfQzdV2nSR6ErhWKooC5E=;
        b=ePJBdirpFPeeUNHvJC3d94QERMHY0C4pPfprSLzDSjo7WAIhqeAmXR5mnjTPBmaLkz
         /18dyL4jWS7LnVpRhjkom9z/WeWoPS/vq8FUht52GASb2KM6+9+jEn+wVf/+n0LbYl6Q
         P4QJkAg6Lz7qmHwdn/d6mSYyM6j35e4Pz7WUE8fMQQsAmGfSX+F+vQFgvs/CUcfT3kbM
         rVDuwY9r6rw+PocDnqGVCuJwvEnFW7Ti6ZsWQ3qycQmHjRzZW1190+NVu2T+x5sered5
         kP1kIkWuSSQWRPN+p9mBRWd/hp0GICwfiuZwzK04OTMRx1U/mN1rIzr4ja/EV76jAXeU
         YnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1e7qAtyTbXCYmyAw0z2FHUgfQzdV2nSR6ErhWKooC5E=;
        b=z9/XNcN+4RSz1ZNo6PlYUcdmqMvtqTuMB7NF+4wtdc2xIdDHnE/vKtvQ2b88npbLac
         n2IT/bZcBs/5UX+Ra5U+zPyNE3LywQwIZtNx04H92JFTdWj2c55a1w9At5S4iNpJbQDK
         IJUQcSlER7PN4Ne6fa37rSm+BdSek0PkBqMeLNM7CwhjTADCCQDWiBM1ecWYMp8EXEIW
         JzqDNvK6yslcNcLJIHHYJ21dDkztU1EkFm5UxpZyHdip1iHjWeGey6DYFeyLHk1j8dZ8
         O8igh7JN+mJPFBOSqXQn2B8agWkmP29N+0hg6gjm7mlCejUbt6mrzR546t5VXzpbHuPP
         6hQg==
X-Gm-Message-State: AO0yUKWAfJB/cEB5huIoQZEmU55GPQVTBiPtX34svqQUPryPNZoC5MsZ
        F8n11EkQXNMdNLTA5vlPhyr4nujvGSBPu8qUXz/eniS2GUs=
X-Google-Smtp-Source: AK7set/Gm9LJ9PXPPK+H5YJdvC1FO1hMJiSfkmsQ7SwDlbbZI+ocUYKOQFEcPvx8tVmqmYM19ntTe3UNAdsvQ+v5KCA=
X-Received: by 2002:a50:f689:0:b0:4ad:6052:ee88 with SMTP id
 d9-20020a50f689000000b004ad6052ee88mr410381edn.2.1676907763113; Mon, 20 Feb
 2023 07:42:43 -0800 (PST)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 20 Feb 2023 16:42:32 +0100
Message-ID: <CAKXUXMwWuh2Qtiq+qQBjU1Qpb-qaphob=YoaoNWS2W_GQui_5A@mail.gmail.com>
Subject: Still a QNX6 filesystem maintainer?
To:     Kai Bankett <chaosman@ontika.net>
Cc:     kernel-janitors <kernel-janitors@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear Kai,

in the course of clean-up of "lost documentation" in the kernel, I
intend to remove the file ./fs/qnx6/README in the repository and
replace it by a section in the CREDITS and MAINTAINERS file, just as
done with all other contributions to the kernel.

Given that the email address has not been used since around 2012 and
the time the filesystem was initially submitted, it might be likely
that this email does not exist anymore.

So, this email is just a quick check if there is still somebody
responding or not.

If no one responds, I would mark the QNX6 FILESYSTEM as Orphaned. If
you do respond, I would simply submit a section with you as a
maintainer.


Best regards,

Lukas
