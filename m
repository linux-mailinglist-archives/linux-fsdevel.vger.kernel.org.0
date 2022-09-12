Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF535B6175
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 21:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiILTHb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 15:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiILTH3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 15:07:29 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CB6422E6;
        Mon, 12 Sep 2022 12:07:25 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b5so16951379wrr.5;
        Mon, 12 Sep 2022 12:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=R1+aRIyS9LUIyQ3zXAPqqNMmqbafvBKpatiJxKWXlqc=;
        b=g0wqe5188i47SDx/DgmXNLqYP401z0BDx4kcSBC/Nr9I1P3mK2GjFnpVzRwjkr/fvG
         og2guTmS657C5LAcHF3Cuwh3dMJAEZ29EO/Ox+zAUWk6syY4608/lANRXJFyfPkJ/RZb
         6rUtSe/lALJ7rpIH/Q5Y6UPQhyP2y4b7brs5l5tFt0cY2TCNJ2bpudF07dBGBJqnCDiA
         UDa2ZdcOx0yFqM5HKRLBSsnrdXd+u1oIA7AVOwZu+8HBMW2pDxHHSixSVcF/yL/MI3g/
         ldg48SfxvNzZKTspjE2LdCXXulZFYniHp53eonhpYoOFTBneUf0T31JIw5T1FQFY1gW4
         XuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=R1+aRIyS9LUIyQ3zXAPqqNMmqbafvBKpatiJxKWXlqc=;
        b=B3BiPBrMdZ8AFLZ79mZDcieSgWmlE8kjBh3PCS/ROt6nwJbQZbrScoKVeh76yNJL89
         mhETIIdPDSyWQrbl3tZ8R14KMLi/VeKQsgfk7RVvUmOyAbh57CQJ7RGyLsio3gL2j9Av
         T/qpnaBRnjC1f3GblywzhhIzf0WHmklZw4TFpJaaj0seXIfXe8qp8sE5I5RVu4Qp6IC7
         sQwxeak+60gRrdAiEtCgwZfFeiuDKAbPeTs0V37n1ZWbFKR1qfL5nYp2apupsXb6CEBa
         DC50vqmNTv/uttDmfi25C4C5LSo5mGELMBdljzS6/waFqksPEkWtgiVL4WfkS3aBnUhe
         LDIQ==
X-Gm-Message-State: ACgBeo11Q59Klp9EPbgixgBgVAPg79IP2qf/oiqQfD1oodiIy0XD+v5n
        jWe4ObdPsZjpwVIxEhZm7hQ=
X-Google-Smtp-Source: AA6agR7XLSNjdLaQ6KU4wiLXBnpws1u+qHnv/evEK5KM3xPrE4aNJhWgfAzLXl/axI7SvYClIGCn8Q==
X-Received: by 2002:a05:6000:156e:b0:226:f190:448b with SMTP id 14-20020a056000156e00b00226f190448bmr16551969wrz.573.1663009643767;
        Mon, 12 Sep 2022 12:07:23 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id b4-20020a5d4b84000000b0022a2bacabbasm8351862wrt.31.2022.09.12.12.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 12:07:23 -0700 (PDT)
Date:   Mon, 12 Sep 2022 21:07:21 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: Re: [PATCH v6 4/5] samples/landlock: Extend sample tool to support
 LANDLOCK_ACCESS_FS_TRUNCATE
Message-ID: <Yx+DaemfpbeuVges@nuc>
References: <20220908195805.128252-1-gnoack3000@gmail.com>
 <20220908195805.128252-5-gnoack3000@gmail.com>
 <c302374d-f380-9da4-c6d9-94b9b4555407@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c302374d-f380-9da4-c6d9-94b9b4555407@digikod.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 12, 2022 at 09:05:03PM +0200, Mickaël Salaün wrote:
> On 08/09/2022 21:58, Günther Noack wrote:
> > Update the sandboxer sample to restrict truncate actions. This is
> > automatically enabled by default if the running kernel supports
> > LANDLOCK_ACCESS_FS_TRUNCATE, expect for the paths listed in the
> 
> except for

Fixed, good catch!

-Günther

-- 
