Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB7A819A889
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Apr 2020 11:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731997AbgDAJWd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Apr 2020 05:22:33 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:41660 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgDAJWd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Apr 2020 05:22:33 -0400
Received: by mail-ed1-f50.google.com with SMTP id v1so28776476edq.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Apr 2020 02:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=T6b+sjRphpcuGSXNBdrZIF59E22k3Rb8J3ECH9sInvs=;
        b=SvYOuxVCZ3eUmsLCzxPfJ/KfeeAyeHyfCO6VwKmgyOKHJrG2FhP8NlF0E65stmaVAg
         Op5zWW9N7x7uCpNPk4QULHU9h5yWpUJfjX0mxl+WRANfTKjQ1kWji8qYMlpupzVe7Onb
         qYe7x6JWnIHIOk+R2GYe0m0nJncDu5SiCeh7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=T6b+sjRphpcuGSXNBdrZIF59E22k3Rb8J3ECH9sInvs=;
        b=KEB/gd5PhlwJ/8grRCAb2CIgkpOPtMQAqeG2EVT0QDBVb9wYDmr4BkuxeIgDAcR0qi
         x49LneLZZZVR69JPIyCuuYCYhdRSycaA852aSwe/e94F6zTl/eFcGyitZHMApa1yB828
         MaRbH8kK0TjHYlfLZKc728I8yxkKioytfveEXE0F4jpG2DRLKO0GDP2ecq6MBuy7xnZW
         t57lUGAe2YJvGjjRWLKySFTlTu1iUPdDx4qjSFhNSMXAthn24FK4Tnjen64lZxYMS8WO
         /iASQc7Ia9jSqAaRh5nf1VsGDSCKejGemMnNwmrdHNXKNI0Iswvvlw1DII/wfDG31R68
         HonQ==
X-Gm-Message-State: ANhLgQ3je1buzA3TW4MXB0HLt5VO2jc79W+Pf4sVhvOQmO8kg5n1wypl
        Rriai5zu66hoicsAxAsyvLLKoad8m4U4icDgrtOTXA==
X-Google-Smtp-Source: ADFU+vtGXW5k3IoBbaicl9fz9MKjBdmViBxrqe0LwR8Vx2FsGuu1GWJO6T6Fr7EVjEes+UOtVSngpVn6vTN8QUp82XA=
X-Received: by 2002:a50:c341:: with SMTP id q1mr20401249edb.247.1585732951273;
 Wed, 01 Apr 2020 02:22:31 -0700 (PDT)
MIME-Version: 1.0
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 1 Apr 2020 11:22:20 +0200
Message-ID: <CAJfpegvv3-oh6iPNXa8bjXmjhkR8KzQPWN4tAH18_tM5wFkQ9A@mail.gmail.com>
Subject: Why does test-fsinfo require static libraries?
To:     David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is annoying:

  HOSTCC  samples/vfs/test-fsinfo
/usr/bin/ld: cannot find -lm
/usr/bin/ld: cannot find -lc
collect2: error: ld returned 1 exit status
