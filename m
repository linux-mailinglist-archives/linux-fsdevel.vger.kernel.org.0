Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29647A5336
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 21:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjIRTpf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 15:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIRTpf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 15:45:35 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F12101
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 12:45:29 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bcde83ce9fso80603621fa.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 12:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695066327; x=1695671127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zW90+4LnhcXuYh4PgbZ4Zl6heO2MhvqvxAqb1aqy9sA=;
        b=KCR/+8gZYD6+QDchae8pwZvJni38Hbn1IT+ROSaQtdjgJ8L+elvODQ9fPv+1Z//Byv
         gStV5BMuMxwhv8bepohgoxGmuqH7X8RGxVXwLtxb2aqmIlkYhqgHPxO2SWf6qhAJYtBc
         wxk1ndck4R/upcAe5XkByj7y1htLnTPWuDKt1R+564SHG5jhoOQlB5H6bNvXjDcUQx9g
         4JCZt2sHyIe2AANQ3/7357FA104vZuowS/PqIcsyT03UJ48BEHIyx4HixZgsfy2Qi5c8
         cYU4OCYOhj7f3NEY0WBIi4diTfQzhIbiA4rAit6ocPbQ7KAEKxXx45xeO9F3qhy5G/+j
         uvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695066327; x=1695671127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zW90+4LnhcXuYh4PgbZ4Zl6heO2MhvqvxAqb1aqy9sA=;
        b=XS8n6UIjJZGKwrGu38WG1Y+HAiu2Yh37NKWn/I9GZWdd8i9lSBWKbQVxCO+RwAOHKd
         xHx6s9GzJ+f9hRY1DwrsggKN2XX2Y3p8Gu8cCdXY7EMipeG64V4I5YY1XyiR2rCq1eKb
         4sMcMVt9iAe16MOtZYK8GSekLycyXsOz7wevWdikss5hcg3vBpidE9qUiHXvbcBKxwV+
         nVmv5ZaaaA6Fcjd3h9E5wkeCvZBZAAjivzfAzyv7QvnPDzmKk4Ne+nxvy0TGMIbOXYZ6
         ogFdk/0NG4ej2K6YjvqKD2WnyWYMyXe5RSlXS2anWZGKjRoubn2HpcboUcIrFNiS05XE
         RIpg==
X-Gm-Message-State: AOJu0YwhvPB/YX6uizDFhd04tdt96v3qCCPX6rrt9KmV9RPP4xI9jm+7
        A2u5nAVfQC7+sFsCY3Dh6pHKGIVSMaEs9a7/Tegzow==
X-Google-Smtp-Source: AGHT+IEL7ZbuHmHMhfSt7oo20tbProZdj8HUKQ/ND2lyRw+9QyGxP5DFrXFBvAttMLQBi94pczJfRMAdGXrMRRT/fgM=
X-Received: by 2002:a2e:9607:0:b0:2bc:f252:6cc4 with SMTP id
 v7-20020a2e9607000000b002bcf2526cc4mr8663483ljh.10.1695066327372; Mon, 18 Sep
 2023 12:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230918123217.932179-1-max.kellermann@ionos.com>
 <20230918123217.932179-3-max.kellermann@ionos.com> <20230918124050.hzbgpci42illkcec@quack3>
In-Reply-To: <20230918124050.hzbgpci42illkcec@quack3>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Mon, 18 Sep 2023 21:45:16 +0200
Message-ID: <CAKPOu+9yAKCtrRZsZPFDtM6RP6Ev_-2x84WYCLf_SPHJcr3Faw@mail.gmail.com>
Subject: Re: [PATCH 3/4] inotify_user: add system call inotify_add_watch_at()
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        amir73il@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 18, 2023 at 2:40=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> Is there any problem with using fanotify for you?

Turns out fanotify is unusable for me, unfortunately.
I have been using inotify to get notifications of cgroup events, but
the cgroup filesystem appears to be unsupported by fanotify: all
attempts to use fanotify_mark() on cgroup event files fail with
ENODEV. I think that comes from fanotify_test_fsid(). Filesystems
without a fsid work just fine with inotify, but fail with fanotify.

Since fanotify lacks important features, is it really a good idea to
feature-freeze inotify?

(By the way, what was not documented is that fanotify_init() can only
be used by unprivileged processes if the FAN_REPORT_FID flag was
specified. I had to read the kernel sources to figure that out - I
have no idea why this limitation exists - the code comment in the
kernel source doesn't explain it.)
