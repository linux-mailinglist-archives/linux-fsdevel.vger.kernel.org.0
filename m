Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236B0394355
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 May 2021 15:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbhE1NVl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 May 2021 09:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbhE1NVk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 May 2021 09:21:40 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDD4C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 May 2021 06:20:04 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id x7so3246643wrt.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 May 2021 06:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=YthirEf9ZeDLy97KC7Gi8iGhW+z3N8nUUM4qX2jcJGM=;
        b=YYR2zfmgUiBwUBZkRA2q2M49NaliKp1/qZ/HnMtI2BU8HzcxeumR8pwc0I+dyVrwu2
         RHsJaeyq4oMcLqLqPoSfvVOgSt5cHlU/Sbn2tHiQ6iiyOb5PozQJZdGvTjQK/06HkdME
         Kco9X6AT5eT53UGbxaZv4yeBWcUY9VQTle8cphfnp+qjPEZQjiVYcqDKWYZQdWxwgcyI
         W0q2NKEnmg+RuUiryX38mSYkB+Vh7wtYWwPssC7oZEQ7EJHjtPcBmDshLpjpe+7+XODS
         srn7LdtZMB+CNaCjyQ7nI0mozVjBAFJbBNtBJhdI1SiVQsFkg7hYBFRR8+TWMbuHm/lH
         g/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=YthirEf9ZeDLy97KC7Gi8iGhW+z3N8nUUM4qX2jcJGM=;
        b=O4DyqpoTLR3kow7ye6YtPnw3F80/Qxf/w3inKY7NdSFRbfWxA7skY8LLO2zyH7Tf6r
         hLNjCZ02Tkm+km6C3efJRKeQAYpEC054CrdqErJR/BjNSufvg5Wr60ICIyYZKd8sFKh0
         qetNKZPAFEyaAu8waS22cCshEEWD5GrQ49VQe6+1kyu0FsDD2S0wRSdC/D6tDn0r0zis
         PA63L2XySyA/ajCNRkaV4uDZjHEs9552ypnFzURt5Yyffv1dCV3P778bHNfs59A0jOHq
         R9E5V3vwDL0tKyZLCfBJnnBcA/CH3niwvff4ccYa6wzpfIaDKvxFi1ZNuSBI6L+04msL
         T9RQ==
X-Gm-Message-State: AOAM531aeglXZs/f5undmgTpO1mvCZNbOUopCDwFlitElPLvp8d5dUfZ
        gAgm1Mpj052AQ0JuHKb13BQEyjeHAzgdIIg3fqciwC1RDO0=
X-Google-Smtp-Source: ABdhPJxrqG9b3pEh7wWbo5nEGOyUxaKetvG9QrZ2kd2tLUHXhGnLUDuBXTX+9/Y2Qe+XdCtCbyFZIEKGXDKn821XieE=
X-Received: by 2002:a5d:408f:: with SMTP id o15mr8485598wrp.89.1622208002966;
 Fri, 28 May 2021 06:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5mspycFk02EzpqF-CT9GwG81VGYp+yQuHoyZFgUsJ1fhpQ@mail.gmail.com>
In-Reply-To: <CAH2r5mspycFk02EzpqF-CT9GwG81VGYp+yQuHoyZFgUsJ1fhpQ@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 28 May 2021 08:19:51 -0500
Message-ID: <CAH2r5ms_VO=kRwhT9KLzUJn3cx-Q+sWfOrHhabpcLGr6y+j7Cg@mail.gmail.com>
Subject: Fwd: Current cifsd-for-next passed buildbot regression tests
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Latest ksmbd test results still look good
http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/8/builds/43



-- 
Thanks,

Steve
