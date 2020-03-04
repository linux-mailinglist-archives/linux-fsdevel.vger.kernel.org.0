Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA77178EFE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 11:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387793AbgCDKyP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 05:54:15 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42765 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387488AbgCDKyP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 05:54:15 -0500
Received: by mail-ed1-f68.google.com with SMTP id n18so1751139edw.9;
        Wed, 04 Mar 2020 02:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=8QzbFRA6IiNqJw3VB0sSGW2728BIelU6Zm/h4QWjC/w=;
        b=ifTB9k2SIikX0bXRmoJBSygY26Cjc/b/hJVS57tW6GKkPrISn9kSGbIL4IN9JuqyxD
         bBjfXiVCqlThb50ciVclbQS1FK0UNQ+tyrNed7yR9YWM2UR6NdER+UsZEk2utYiUrKSc
         Bzk9KD55Izv+ey7gCz8bBv3Po9SDD/Vzafn2pHgZw6aZM0kGXZutz6O1BF8XEy6g912v
         J6MCSay7vyXL/1IVGiOtkrQXU8OxGfNjcMHQQGc98vvxJ6fT9Hc9xaQQ4/cWC3oQ5u6Y
         hhjpjzrov8DCakHO/5M7S55ct20LvTKO3z2PRPc9sG3g8WjEjWjeKmfEnvi/URTXVmpy
         o9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=8QzbFRA6IiNqJw3VB0sSGW2728BIelU6Zm/h4QWjC/w=;
        b=jYjm8IsC8zcid4B+d85NDGKi4TfxhM0Lyo6P4NOfH7L8w0xKjyoHX+iolbbOL5fDum
         etMBvyznuRfOMnKseQWfz2KaJOH2E7xPKLVSdbFQ/L0unCVhinOV8gAdPicswZqW9Oa6
         estFP0qRj55mt0s9IEdO9XY1dCQ2uy45gi+11UTJOXOlRmdTtLq9ZQf0iphcfLSxlx5U
         1jb6+Rff1W8bjnPmwSmO4DnkYdGD/H2Ehg831tMNP3CsVUIRDOF5Tdt4mLDIx/+3mwXO
         8mvYg+9AlOQRex/yTdY9xgZ5Cho9K7zByyNKZh2bW8frXUpqm27flQEju7exfbd/lBAj
         cV6g==
X-Gm-Message-State: ANhLgQ3xf2igBIyfx0w6wZpuuybssn3FKZrzQhArt2fNTMECkJe1MH1Y
        zkk4s5f/dT1VLDMJfPpgVGA=
X-Google-Smtp-Source: ADFU+vvlTrDBpWeylkN1foJZYPynGXH45f0hE15eWSEP2mWXW9xtOm4h8Y9mGhvXCjW7PhUWOCCmeQ==
X-Received: by 2002:a05:6402:b85:: with SMTP id cf5mr1996726edb.27.1583319253470;
        Wed, 04 Mar 2020 02:54:13 -0800 (PST)
Received: from felia ([2001:16b8:2d16:4100:3093:39f0:d3ca:23c6])
        by smtp.gmail.com with ESMTPSA id u5sm856485edy.61.2020.03.04.02.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 02:54:12 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Wed, 4 Mar 2020 11:54:04 +0100 (CET)
X-X-Sender: lukas@felia
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Joe Perches <joe@perches.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: adjust to filesystem doc ReST conversion
In-Reply-To: <20200304085905.6b71fe8c@coco.lan>
Message-ID: <alpine.DEB.2.21.2003041152030.6023@felia>
References: <20200304072950.10532-1-lukas.bulwahn@gmail.com> <20200304085905.6b71fe8c@coco.lan>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Wed, 4 Mar 2020, Mauro Carvalho Chehab wrote:

> 
> Btw, those can easily be fixed with:
> 
> 	./scripts/documentation-file-ref-check --fix
> 
> I had already a similar patch to this one already on my tree, intending
> to submit later today. You were faster than me on that ;-)
> 

Thanks for the hint. It is always good to know about the various check and 
clean-up scripts.

Lukas
