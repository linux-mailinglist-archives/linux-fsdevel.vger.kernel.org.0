Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1812A70AD43
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 May 2023 11:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjEUJhH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 May 2023 05:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjEUJgW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 May 2023 05:36:22 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5356DC
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 May 2023 02:36:16 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2af2b74d258so17253451fa.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 May 2023 02:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684661775; x=1687253775;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4jlL8pzL6NVZbuVjV4h5KPilkuQmPMJRpXcDIhZ2tX0=;
        b=J9fCeM50HI6aKasuIiiiBf3sJUClnRowBaahZbOZb2yxWyeV+TeP848caKwyiCxcw0
         TNQywZMRTBBlYF2L2Ow2vLrf/MlQhyhztcDSFnX5RdQdswuZyBesjwgx4FSmwsMAxDuB
         tdPmPvcNmOWxOqRZtgFW8s3DqoWLw3xNNxq7rarqq1Kwzet9NDCuX5rTsGcMbVeuhtc4
         aBYs4KrC+6WRqQ2O7h4hpE+IIPMgXAvzj400NqLjz5z0pGIbz0nyURu/2NFdwYKrIcoi
         +U674wUxpyEvWw5etbYF6B5nTI049vDgv/zwImjqEPMVUX5DKvIh1MPUFDvpJH/gKXNi
         9MjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684661775; x=1687253775;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4jlL8pzL6NVZbuVjV4h5KPilkuQmPMJRpXcDIhZ2tX0=;
        b=A/jIOpqJOelRcX9DOYD8UcRPXoY58eTkUz4p0HGhhBcDGDxLfugVHKBnw7tlgKnt75
         rU37Ve+ksbwanxhT6F6Qw72gR5yt+0b6BP+5WvMT4Yd6pUXMA3Mi+UPK9t5+vgtsbLCr
         o7ehcPq4bFeEUv6FM12gf8gLkp3yKGbTZU4S+PbN2yT9aVtKciNIF7h1n4r5gwPK1dD/
         okTmrchCu/bMwgLnRaBqi9cjpzHwc9FXlT/9Icejy9CHtUWHzafV7Awdm+ymydj5x+J7
         Tr3BdE6kFg9FYSWDqJNbUxJTpOlPEZ33vjjprdb/Eq/cmuLGHTpxBEtX6cWFjPZqU+Hz
         xyog==
X-Gm-Message-State: AC+VfDxjzIy8sj7mKVWqEG4ZGDcaSA/o8BwhVmZL1h1hg7fIk54Hd2eo
        8xOmOlBm4d/S66nIar+x3VzYYcaO14ZnH8uBHLw=
X-Google-Smtp-Source: ACHHUZ7vkIHaMuXduxVNHyZfndou0BiGfzrY2X+0hMOHbxdAyTy7W5l5B/6zvlWq/LvdJy45CmvcsGaEr3kKk1yGrCs=
X-Received: by 2002:a2e:919a:0:b0:2ad:988e:7f8e with SMTP id
 f26-20020a2e919a000000b002ad988e7f8emr3206317ljg.51.1684661774640; Sun, 21
 May 2023 02:36:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:240b:0:b0:2a8:d38d:f29b with HTTP; Sun, 21 May 2023
 02:36:14 -0700 (PDT)
Reply-To: ninacoulibaly03@myself.com
From:   nina coulibaly <ninacoulibaly90@gmail.com>
Date:   Sun, 21 May 2023 02:36:14 -0700
Message-ID: <CAMPxFe=KMVBx4Q3zMsR6aOAiAxpsGtO=amW+8dQwT88qkAX9pg@mail.gmail.com>
Subject: from nina coulibaly
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear,

Please grant me permission to share a very crucial discussion with
you.I am looking forward to hearing from you at your earliest
convenience.

Mrs. Nina Coulibaly
