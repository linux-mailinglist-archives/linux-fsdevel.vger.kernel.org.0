Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8935B7A65AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 15:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjISNsx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 09:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbjISNsw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:48:52 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE5883
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 06:48:46 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bffdf50212so41222861fa.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 06:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695131325; x=1695736125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WNBNrR7zKfOyERt5cNupmOKUcEiwUylmVn103vlUQ8=;
        b=gIBAFw1HrX8CCwPKmoRqd5W0twDvP33c8DZhO7JasEHDesK5p2v85nqVOe7Vi95I9y
         lyFk9ah1dZ8kGOj0sxkRuCmn4Kt/vEukkms1F90F993TyX6iPWZSzfXAMN+K7iFrZGCV
         766Wmy49D8gehZBodc2xOsVXDoU0hlJ59ahxAKidSjSQjNLvhJJxC3tzrNDSFeJUYUtp
         GOoNZMPMR1z+J8ewZVnoVlI5TTmakZPtRx3dImAl0Ym5tP+J/IKx696MFzp+evQZ8/+4
         orAXHSiNnTrvrjEBV1M3/9vxRmfhkdS1+1S7GgVSdhnh7LNY32T9nnqkNw83Od527v0K
         bvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695131325; x=1695736125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WNBNrR7zKfOyERt5cNupmOKUcEiwUylmVn103vlUQ8=;
        b=EATXSlwL9IL84I6NuEVoGrT+M0M9COYrqnxkp5DAtn1Wqo5q5Z6qRIXf/dwMh2sUov
         INQKxCwggDLwzZVOrnTlse8SOLJ12x6vl/y/vWgEoVVuaCkpm/X9dKl7/1uqV6HSO4ef
         krW4loCe8wMnPv7A/1dWODPHCW9o/8qer+OqN4XGsvypesHmY4Ke6yU3hnz6E4oteN+g
         Ef9w8ARFqeAZka6jAGqgQQZMN8h1UpER5vk6mbf4KNmgP98GCVLEMgHoaFKi/UDTn2aF
         NujPXM1XKqaTinq5kyEihudDwvCG7iCMlOOvaAzmb3cfG95z/gUKVfoMYuaS+qz6wDIk
         ioXw==
X-Gm-Message-State: AOJu0YyIiJnPL/M/uvha/K9wnAKZxBaChDFw3tyWCQ2yIQNT9CnCtMjw
        3SLXWg0Z4iWfrjrnRpgv8OUawP5Q1DM0VvWCncZaSA==
X-Google-Smtp-Source: AGHT+IH7mgzSrtLm80kggKIqYsCbNQ1lw5YyL/y14fSqx2DAxju1O1CL9/AX4/61Fs8CUOG5uhA5yKmO5gYEFAS9/08=
X-Received: by 2002:a05:651c:97:b0:2b6:d6e1:a191 with SMTP id
 23-20020a05651c009700b002b6d6e1a191mr10124531ljq.23.1695131325130; Tue, 19
 Sep 2023 06:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAKPOu+-Nx_cvBZNox63R1ah76wQp6eH4RLah0O5mDaLo9h60ww@mail.gmail.com>
 <20230918142319.kvzc3lcpn5n2ty6g@quack3> <CAOQ4uxic7C5skHv4d+Gek_uokRL8sgUegTusiGkwAY4dSSADYQ@mail.gmail.com>
 <CAOQ4uxjzf6NeoCaTrx_X0yZ0nMEWcQC_gq3M-j3jS+CuUTskSA@mail.gmail.com>
 <CAOQ4uxjkL+QEM+rkSOLahLebwXV66TwyxQhRj9xksnim5F-HFw@mail.gmail.com>
 <CAKPOu+_s8O=kfS1xq-cYGDcOD48oqukbsSA3tJT60FxC2eNWDw@mail.gmail.com>
 <20230919100112.nlb2t4nm46wmugc2@quack3> <CAKPOu+-apWRekyqRyYfsFkdx13uocCPKMzYJqmTsVEc6a=9uuA@mail.gmail.com>
 <CAOQ4uxgG6ync6dSBJiGW98docJGnajALiV+9tuwGiRt8NE8F+w@mail.gmail.com>
 <CAKPOu+9ds-dbq2-idehU5XR2s3Xz2NL-=fB+skKoN_zCym_OtA@mail.gmail.com> <20230919132818.4s3n5bsqmokof6n2@quack3>
In-Reply-To: <20230919132818.4s3n5bsqmokof6n2@quack3>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Tue, 19 Sep 2023 15:48:33 +0200
Message-ID: <CAKPOu+_mssYbub+ds-hQ6eNfSxsjm9CkdJHsrb-kt6JCY9NQ0g@mail.gmail.com>
Subject: Re: inotify maintenance status
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Ivan Babrou <ivan@cloudflare.com>,
        Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 3:28=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> Inotify event is fixed length so
> fsid+fhandle is completely out of the realm of "easy extension".

(Not quite true, it's variable-length. But that's not relevant if
we're talking about adding an optional feature.)

If I were to implement this, I'd add a mask bit called, say,
IN_FILE_HANDLE. If that bit is enabled on a watch, the
(variable-length) inotify_event would be followed by another
(variable-length) struct that looks just like fanotify_event_info_fid,
containining fsid and file_handle (of course, only if the same bit is
also set in inotify_event.mask, which would give the kernel a way to
omit it if it's not available for a certain file).

This is a backwards-compatible extension because it's opt-in. Only
applications which support it will set the IN_FILE_HANDLE bit. Old
applications don't set this bit and never see this trailing struct.

Max
