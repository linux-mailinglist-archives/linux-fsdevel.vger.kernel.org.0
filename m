Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904BC6DCA2D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Apr 2023 19:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjDJRre (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Apr 2023 13:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjDJRrb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Apr 2023 13:47:31 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53299171C
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Apr 2023 10:47:04 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-54ee108142eso114344707b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Apr 2023 10:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681148823; x=1683740823;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rtR1KQ3AqrOVvZCzQlb6jCWmGPQKc6qNmt9LztgmJM=;
        b=BqbhM9JMvMAyMmkt7kMrlBFKSDVBInnQ1LH97f8g/RNriLbcr9kGlvFiM3kFx9p7kT
         k3DElh125L3hk2n0Oq02XuS+WiFPPfz0sSvZSZ84yCA5Q/wQj7MLaoqC8WAYECZWqgFE
         JSf9VFkalZBIIBX9YFvNBWPWX2cdfo/TkEn0UoNVO+xtFEtGHOH0XKmzqb8P4icODO1r
         x5e/JsFjPI6CcwCQvS03Z2iXtfZ/bbrsxDUvjd5Qy2UbfhXhGdaOKZK6C4OSB1AEcPif
         y9wkz7D60qzPGCDFFz25BUfeOgY+OEGzm2lpZweBi4Dg1IUn85XAOaKhriu84dKvF5Ho
         STXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681148823; x=1683740823;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rtR1KQ3AqrOVvZCzQlb6jCWmGPQKc6qNmt9LztgmJM=;
        b=77goSSv4C3xocKkqhGU48PKvvkDz8UQOGuaXBMJiNAOBW94dQ9P6UyiSQngkG4OiGV
         /Vz2zogX2xEexZtP58hUW+FxCuULgZV9DjjKxqX38znJ2jJAQ5PC4siHdJiHnjxNv4uR
         QwpyYlP5iJSO50kbgR8ljIhgBLXL3wzBLyACAuTlSbm66b1yjefSEm2Ew3rwomyHCZhh
         ArYuR9RvSmGI0NT2UDAJy06o8Sw7z26rAHNBHuz7b/Kp84jt9i/70hE6uUxJo50XJcUk
         0YtkQ2TUnmirRVZTvIDwJro1PHbfWNc/P4gUDcJiBk5RxObjrnOPynajHh9rJACCMv4T
         AMyQ==
X-Gm-Message-State: AAQBX9doHR0KW3o8XASOm3rmKWjKfXsKwsFTa6ODm3TRSyRxguODyIoJ
        t0VmXM11SumbbVapBXG6PHn2nnDbSZc3rNY8hvw=
X-Google-Smtp-Source: AKy350ZDxReVUeZGSiN9OtREAUcY12spdX+6/+Rz+W9m1AdQN2kfh2aFaMblSkdCUrERM6FGfbByAw==
X-Received: by 2002:a81:4890:0:b0:54f:3322:cbec with SMTP id v138-20020a814890000000b0054f3322cbecmr210620ywa.28.1681148823539;
        Mon, 10 Apr 2023 10:47:03 -0700 (PDT)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id 80-20020a811453000000b00545a0818480sm2968877ywu.16.2023.04.10.10.47.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Apr 2023 10:47:03 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [External] [LSF/MM/BPF TOPIC] BoF VM live migration over CXL
 memory
From:   "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
In-Reply-To: <20230410030532.427842-1-ks0204.kim@samsung.com>
Date:   Mon, 10 Apr 2023 10:46:50 -0700
Cc:     dragan@stancevic.com, lsf-pc@lists.linux-foundation.org,
        linux-mm@kvack.org, Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-cxl@vger.kernel.org,
        Adam Manzanares <a.manzanares@samsung.com>,
        Dan Williams <dan.j.williams@intel.com>,
        seungjun.ha@samsung.com, wj28.lee@samsung.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <1DEC12D4-9D85-4AC1-BEE5-92E7E8189C2D@bytedance.com>
References: <5d1156eb-02ae-a6cc-54bb-db3df3ca0597@stancevic.com>
 <CGME20230410030532epcas2p49eae675396bf81658c1a3401796da1d4@epcas2p4.samsung.com>
 <20230410030532.427842-1-ks0204.kim@samsung.com>
To:     Kyungsan Kim <ks0204.kim@samsung.com>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Apr 9, 2023, at 8:05 PM, Kyungsan Kim <ks0204.kim@samsung.com> =
wrote:
>=20
>> Hi folks-
>>=20
>> if it's not too late for the schedule...
>>=20
>> I am starting to tackle VM live migration and hypervisor clustering =
over
>> switched CXL memory[1][2], intended for cloud virtualization types of =
loads.
>>=20
>> I'd be interested in doing a small BoF session with some slides and =
get
>> into a discussion/brainstorming with other people that deal with =
VM/LM
>> cloud loads. Among other things to discuss would be page migrations =
over
>> switched CXL memory, shared in-memory ABI to allow VM hand-off =
between
>> hypervisors, etc...
>>=20
>> A few of us discussed some of this under the ZONE_XMEM thread, but I
>> figured it might be better to start a separate thread.
>>=20
>> If there is interested, thank you.
>=20
> I would like join the discussion as well.
> Let me kindly suggest it would be more great if it includes the data =
flow of VM/hypervisor as background and kernel interaction expected.
>=20

Sounds like interesting topic to me. I would like to attend the =
discussion.

Thanks,
Slava.

>>=20
>>=20
>> [1]. High-level overview available at http://nil-migration.org/
>> [2]. Based on CXL spec 3.0
>>=20
>> --
>> Peace can only come as a natural consequence
>> of universal enlightenment -Dr. Nikola Tesla

