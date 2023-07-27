Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF177654A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 15:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjG0NKw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 09:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbjG0NKl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 09:10:41 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949FC2D63;
        Thu, 27 Jul 2023 06:10:17 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe1489ced6so1662395e87.0;
        Thu, 27 Jul 2023 06:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690463412; x=1691068212;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mi+oPTTzE1C4HQcitXRKVgEJcROJC+7Sg1+tAjSg2p0=;
        b=IM5/7X2v2Xih+opN4AsiOyB/ZCEZ8R+xtKyk3NglW+OcIgc5nNUDDt7YOj+niXvVgt
         0BTbXhCaLi+jfAJG60joKtlFQmjn0k/68ybDwOB+CcHcdh72kSjokSpfgXl9ITYypbZf
         DCxEGdw8doCbSFUmKmNpXYxBZJFVY1BkzOg4kuqYNbjYeqRZ82WFfOnaBB69/GvJ9PwJ
         G+IHAoA7rL+rwNrvRnPGA7cDgJ7iaT8JE+53J3rA2uyPUUm61Zb+Wo0arRa/L2sSLQW8
         Ln9jqi1DVokbnRrBAAJRiL/XOkgtJThBmBRujPuzrcA4PPrqEejmMmVv3Kpr1SCQN1N2
         HMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690463412; x=1691068212;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mi+oPTTzE1C4HQcitXRKVgEJcROJC+7Sg1+tAjSg2p0=;
        b=IPhv1IG9D0k40fp9X6gB2wv8ZdL3sLW7w2o/ewgNfdprLHcfI8LIqiKbJ8xFmn92yr
         eGv1ALk9h/lrO3tlIkw2jOHatZEuuapAmlFwsvY6g6428KsOMdIE2e0WQO9kZA2BSedP
         +AIOeOJ5hNxwT5ZA2KC7AZwTP+tXK08e4GSQDgRg3iClWmuTTLq3Zm40QiLE9mH2C+JV
         pafSm7t68fMf5iQ+T2IPoJnPYzryHxMcDAFBmRAUtkF1xR8KSuHdzTjL1H1O8EOIymfA
         6vkbWbMRlEo75+bsmWV09mOQwnTcuP+xjdxC0wnyQyAyn8LRS1E92wcw6r2/MmgcVWXf
         1fkg==
X-Gm-Message-State: ABy/qLZsuvrfKFGlFcYrMtAzmn/dOWtcq1cD8Nxwoi+kCQGoR/JwHYe0
        VmUTiGwDqh0qDeLqQBYE+82f+ji32Jw2z/mZg7w=
X-Google-Smtp-Source: APBJJlHALcjQJpKbuUhVh8VlUyjFsJb/YAYdHbIX5DRuaT0JU9A4uZdvVnD25gJHxzCg3AVCmyXG2/noLcwkiHhGOu8=
X-Received: by 2002:a2e:9b0a:0:b0:2b9:ba02:437f with SMTP id
 u10-20020a2e9b0a000000b002b9ba02437fmr1895347lji.3.1690463411731; Thu, 27 Jul
 2023 06:10:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230726164535.230515-1-amiculas@cisco.com> <20230726164535.230515-4-amiculas@cisco.com>
 <CALNs47tkc2vWYW13LQq17Qcy0UFBJXan+7S_JVsPBXwTTJn3bQ@mail.gmail.com>
In-Reply-To: <CALNs47tkc2vWYW13LQq17Qcy0UFBJXan+7S_JVsPBXwTTJn3bQ@mail.gmail.com>
From:   Ariel Miculas <ariel.miculas@gmail.com>
Date:   Thu, 27 Jul 2023 16:10:00 +0300
Message-ID: <CAPDJoNv4N0fh075J9MppDOHzFyMXP0NuWsmt4uXNcb_C-RiR+w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 03/10] rust: kernel: add an abstraction over
 vfsmount to allow cloning a new private mount
To:     Trevor Gross <tmgross@umich.edu>
Cc:     Ariel Miculas <amiculas@cisco.com>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tycho@tycho.pizza, brauner@kernel.org, viro@zeniv.linux.org.uk,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks, I've applied your suggestions on
https://github.com/ariel-miculas/linux/tree/puzzlefs_rfc
