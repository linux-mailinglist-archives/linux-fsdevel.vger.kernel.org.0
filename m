Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCBA52D784
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 17:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240928AbiESP2C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 11:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240921AbiESPZv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 11:25:51 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E756263A
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 08:25:49 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id fd25so7434955edb.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 08:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=QTIQet1MwfaPkuVkZ6VAO4F74yKlRL1Luu8IUjHxYMk=;
        b=l5svAHMFi6jauc3S7FX1DSGsV4mLJ6QQLIh3+rvFHlDUF24PdDRSfAjzgFwm49iJA0
         NNE97fjiMLBGBtFHfDtvXWYYjbqJi8iEGw3rJ9JZ0SfbRfZxVUjm+1AcAAGsQiCmn+ee
         89gRyY7ZHIuDSeuO9fuwbQvPzhQmzgICC/Zi2cvMq2Lohgjpg55kK0iwP+n2k0T3yUlz
         q18HivfgFoQnhbgYxOH73LlZzlbv2CCITUbrLuXpgXq0vqfrPGH3EtRYLR0iE9Cf3tIo
         jDXJ3/g1yY1JU1XpBiIE3iub60yT7wRm4Z2jDiczHn7xwf/pOKwY8+kEsQfKRV1mJHdJ
         KpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=QTIQet1MwfaPkuVkZ6VAO4F74yKlRL1Luu8IUjHxYMk=;
        b=JF4pYQm/dUZUPBd6IjxjlV2eXQ+Y0HWtE+rZu9cfCDm0utSRCQGQAj7sGybSS2/AF0
         6BI/OMkAwW1WiumTU+PFUXCF5LclvYpqDqTjrSuoGLUdTgQoGuhYmZ4u9zabOeeo14km
         pUNVOkUgWt8v4HWJO6MOob0DAzhnuUxOYLYKfl7oZEzzMzFfLfTIrQ86a3f2NlIfvz55
         /P6phkxosfP6HK3vcIR5OgniNQHwnOj8sBSzL7iivVc201jk7eGNQdfQJI5SkeDBjg4I
         t3x1GDj8a7vlcO8xFtvCd4BIzsexI1CBZ5djJpNaa+n7vzPUtMfLXCKvyJiR1F8hi6u6
         yfWw==
X-Gm-Message-State: AOAM530UdPq+CaIc8APQ1SWaiDM+O4pwLG/tUn0CwUlX3dGTOErNcgJD
        T1d7HrEeqk9b26kDvfAwAR9sMw==
X-Google-Smtp-Source: ABdhPJxqZsGrBLw1XfZ4Nx2omW80JrXR4I67dHiPrXDO/V/6B5AKsOnb4m6w+WedzFlbburvxrD0kQ==
X-Received: by 2002:a05:6402:2741:b0:41f:69dc:9bcd with SMTP id z1-20020a056402274100b0041f69dc9bcdmr5928160edd.239.1652973947883;
        Thu, 19 May 2022 08:25:47 -0700 (PDT)
Received: from smtpclient.apple (5.186.196.163.dhcp.fibianet.dk. [5.186.196.163])
        by smtp.gmail.com with ESMTPSA id ca7-20020aa7cd67000000b0042617ba63absm2892556edb.53.2022.05.19.08.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 08:25:47 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 00/13] support non power of 2 zoned devices
Date:   Thu, 19 May 2022 17:25:46 +0200
Message-Id: <40FFE5A8-35B9-4707-8D8C-A24254EB9A9B@javigon.com>
References: <20220518080020.GA3697@lst.de>
Cc:     =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, pankydev8@gmail.com,
        dsterba@suse.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        jiangbo.365@bytedance.com, linux-block@vger.kernel.org,
        gost.dev@samsung.com, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com
In-Reply-To: <20220518080020.GA3697@lst.de>
To:     Christoph Hellwig <hch@lst.de>
X-Mailer: iPhone Mail (19E258)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> On 18 May 2022, at 10.16, Christoph Hellwig <hch@lst.de> wrote:
>=20
> =EF=BB=BFOn Tue, May 17, 2022 at 11:18:34AM +0200, Javier Gonz=C3=A1lez wr=
ote:
>> Does the above help you reconsidering your interest in supporting this
>> in NVMe?
>=20
> Very little.  It just seems like a really bad idea.

I understand you don=E2=80=99t like this, but I still hope you see value in s=
upporting it. We are getting close to a very minimal patchset, which is also=
 helping to fix bugs in the zoned stack.

If you take a look at the last version abs give some feedback, I=E2=80=99m s=
ure we can end up with a good solution.=20

Can you help?=
