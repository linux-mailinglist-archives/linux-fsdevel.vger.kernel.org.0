Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927B85ACEA4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Sep 2022 11:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236811AbiIEJQZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Sep 2022 05:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235874AbiIEJQW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Sep 2022 05:16:22 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DDA3C17A
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Sep 2022 02:16:22 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id k2so8234440vsk.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Sep 2022 02:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=VA5GF8Qf6Ya8yZFliYZv62HNNayZ1Hz818zwJmx6RJU=;
        b=QoiPGyFTLLwqxWnsnv04swqcscJDpzLUu20RfmXyVGprNRInByEJIqt0md8we3/Dmz
         3H8Rs/EQawCkchDPlCSQn1hDqN7QVrTO9ggAKYCpNx33mOo5hEiLHzcTOQ+C3V/LxsxH
         cNPOOpzJBpr2j+I2k5qMA1yWyUAlCUvaPveMz49SGtlrEZ9lEMWDX1gX469SnOzUHbVp
         u1ZJ43sF8aQWV08qhQLVTs+chAHBRkFdMQd3UUDrJUnj+x09kFH17dkLl3UC7iJbntLQ
         OvjFdWX8NQ2W6+CZl8GR5lwcYhXa0jP3654jfoK2F8rO19PsEfb5nIaGSV3RvT7rFUiS
         LmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=VA5GF8Qf6Ya8yZFliYZv62HNNayZ1Hz818zwJmx6RJU=;
        b=0k/SzALmshRQG2RGJBd44rkY4j/SMyvpTVBl+DGhK6RSYTJWjJwR4k48c5qN1+G+5C
         ujry/BNlaKa+QKsgOf0i8ufFDnDzdxIysorfV9FRuSQVvOW3uQ9tN1ImEUZKgVPHlMjd
         RULPiKG9J9iHlebPARn276pj72P0aAqanzpdsBOec5N7po8/cPtfP7U09tcrLuN3WP2o
         iRkVjFPssn+t6ZDPFi4a03mSrODQRMa63V6xjYDtJFfYn0Ee0KsvIlq9Cj3qyy63k4oD
         1t6Y/s3PF6gsqGb/SCv7JRmCMtjgw3uswPQeIr+tDrBvqVUgNzOjRXo43ZMRlkp+8nzC
         ZiCw==
X-Gm-Message-State: ACgBeo1KC0nw4e5LSbb69eWwshzSdc2IgSBoNG/OJsVQMs88XQngS9Y2
        DhVcxa3LVv5hWotpKfO247pvnhOMEbb6iTTVHXA=
X-Google-Smtp-Source: AA6agR6ffYM8helg7Ylff36CsQdH9WyqAW7mF26IpGnCEH5QpF+vQrRyKXO+ub78W5ffqnC9llYhRvhtlAc7UA+1uKI=
X-Received: by 2002:a67:a246:0:b0:38c:9563:d2d8 with SMTP id
 t6-20020a67a246000000b0038c9563d2d8mr13326621vsh.2.1662369381104; Mon, 05 Sep
 2022 02:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpegsF1Oohyq942pF0jBxuiybGuP8xab-kvsDU4rbyDRb7xA@mail.gmail.com>
In-Reply-To: <CAJfpegsF1Oohyq942pF0jBxuiybGuP8xab-kvsDU4rbyDRb7xA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 5 Sep 2022 12:16:09 +0300
Message-ID: <CAOQ4uxj309jKiGrGBduoOr17rZXUD25JfHk5cQRus_qpSYBaqQ@mail.gmail.com>
Subject: Re: switching from FAN_MARK_MOUNT to FAN_MARK_FILESYSTEM
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
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

On Mon, Sep 5, 2022 at 11:59 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> Hi,
>
> Is there anything that needs special attention when switching from
> FAN_MARK_MOUNT to FAN_MARK_FILESYSTEM?
>

Well, if you want to get events from all the mounts then
switching to FAN_MARK_FILESYSTEM makes sense.
It also allows you to request more event types.

The only benefit of FAN_MARK_MOUNT that I can think of
is that it's the only way to implement a subtree watch in the kernel
(using a mark on bind mount) in case you can control which mount
users access from (e.g. container) and if you only care about the
events that are possible on a mount mark.

Thanks,
Amir.
