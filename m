Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89714179A99
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 22:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387931AbgCDVCl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 16:02:41 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46294 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbgCDVCk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 16:02:40 -0500
Received: by mail-wr1-f68.google.com with SMTP id j7so4213947wrp.13;
        Wed, 04 Mar 2020 13:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=NEFs2MX2HBD3Da9qWclQMksmz31HvstBlw6pDvT6iSQ=;
        b=N03l14QpofeCXOwJXLkIy6ov4cbP2By/AZf3fm3ywZ6osNrkAw/edkSKoGg26BFgIy
         emyg2CUWOcV8Y7R+NMmBc2dM92cup7X7A0jZynmJmdo+u0RWfWAXNo7z5edQhFisQU4v
         ppzjdSYyO4ShpZ0h9ZwzGI/QnG8d9JX6+8mtdW+TQpzlVDcMrCZ4OEo/+fGrcmWWNj56
         2hx4NJH1gFXQjDMPmpXuSk3uS/1gxHlm+m/GIWVVQ6KY/vgJ6faOvbFMKfDSaGvxF41b
         7fzisDinYlS33G15O+ocNM4RnWnq5E0m8vpdw1OdDMXV1f1v/Bs2N/Y8fmu78/wuxZaB
         ynxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=NEFs2MX2HBD3Da9qWclQMksmz31HvstBlw6pDvT6iSQ=;
        b=Ib8IrDBoEKJ0gJrDVjKaCklvQCZ+9Yn5YJzpU6LjQYE7FQvPUXmt0qxVMZr2t9m275
         ZeDw1KVg6x6+zHGyhjcqvoJQSh3YysSabliIyyUZL6TF9FKmaTt+kKMmeN9upeclC/UV
         0GV5tw7ixMK3gDIW7N8+iSHf0d3mNrxMHMnFscmfaiEXY4lg1kzNxVLNtueZ8GZje1Kh
         7KQyPlc42y+HH2obtUSgcSyr7s5VmvGEr7qfA8SuAz6csnqvL5RwRiAosMzMte/eMofu
         Y7UmtL4peJv1ThS2Hfcyd7r9wqAn3c0xuXWqiM39+YwEH4KD41IeD4GXfMElYDqRtYnf
         i2VQ==
X-Gm-Message-State: ANhLgQ0XU2v06G0LklOwZatXG/GB4HKB12CBAZapt0SPsOxMBy8UnhBV
        j9RFSwKi2Igp+NOLcJNMHKg=
X-Google-Smtp-Source: ADFU+vt7GyKW2cIsrJdFhVMvmrn9ud46HhYHOhye8TeFKkHP5sDs31FglV7g0UQQ0Uj6nor53IgKaw==
X-Received: by 2002:adf:de12:: with SMTP id b18mr5776099wrm.268.1583355757945;
        Wed, 04 Mar 2020 13:02:37 -0800 (PST)
Received: from felia ([2001:16b8:2d16:4100:5c62:5f:595c:f76d])
        by smtp.gmail.com with ESMTPSA id j20sm6100249wmj.46.2020.03.04.13.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 13:02:37 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Wed, 4 Mar 2020 22:02:35 +0100 (CET)
X-X-Sender: lukas@felia
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
cc:     Jonathan Corbet <corbet@lwn.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: adjust to filesystem doc ReST conversion
In-Reply-To: <20200304212846.0c79c6da@coco.lan>
Message-ID: <alpine.DEB.2.21.2003042151430.2698@felia>
References: <20200304072950.10532-1-lukas.bulwahn@gmail.com> <20200304131035.731a3947@lwn.net> <20200304212846.0c79c6da@coco.lan>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Wed, 4 Mar 2020, Mauro Carvalho Chehab wrote:

> Em Wed, 4 Mar 2020 13:10:35 -0700
> Jonathan Corbet <corbet@lwn.net> escreveu:
> 
> > 
> > Sigh, I need to work a MAINTAINERS check into my workflow...
> > 
> > Thanks for fixing these, but ... what tree did you generate the patch
> > against?  I doesn't come close to applying to docs-next.
> 
> I'm starting to suspect that maybe the best workflow would be to just 
> apply the patches at docs-next keeping links broken, and then run
> ./scripts/documentation-file-ref-check --fix by the end of a merge
> window, addressing such breakages.
> 
> There are usually lots of churn outside the merge window.
>

Agree, it is probably the simplest solution to get such things fixed at 
the end of the merge window; there are many of such 'automatic' fixes (and 
scripts that generate them). It just needs somebody to convince Linus to
have a trusted end-of-merge-window clean-up team to provide a final pull 
request on Sunday afternoon to fix all those minor points.
 
> Another alternative would be to split the MAINTAINERS file on a
> per-subsystem basis. If I remember well, someone proposed this once at
> LKML. I vaguely remember that there were even a patch (or RFC)
> adding support for such thing for get_maintainers.pl.
> 

I would also support that idea. In the meantime, I am looking into the 
effort to identify and fix these issues when they are submitted to the 
mailing list. It is not the simplest solution, but at least a solution 
that I can try to work on individually at first.

Lukas
