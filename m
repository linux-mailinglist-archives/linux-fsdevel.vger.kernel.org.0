Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98847BD476
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 09:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345374AbjJIHhf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 03:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345426AbjJIHhc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 03:37:32 -0400
X-Greylist: delayed 597 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 Oct 2023 00:37:31 PDT
Received: from ci74p00im-qukt09081701.me.com (ci74p00im-qukt09081701.me.com [17.57.156.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871AD8F
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Oct 2023 00:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1696836454;
        bh=LfdDfP7afHg0+pYNUoi66ix3pNWQ0ihFFSxg9Z9gNQs=;
        h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
        b=SUMhIKjOGKNXbvWN1mQjfdBmgh2ZpUr9QkSd7sABAwBDaDUt5f1BLSU8zIb6qxDx5
         vMYDYboIcXBNnLnffVB0y3VR0zZFBCtBOoOr1IlrnWpSbfTlnEIN9wC3hDK41PDjHZ
         U2sR6zaerhlFDIAPBbqmKKQthuFfIP/HA3oZIHGjcv/l2xKDKTroS2t76c1ERIzaON
         SZAsSYrwyxhwun+S1BKtBM2zUORqNon80PvT6FeIDT9OmvN6rHSDz4sFcJaGlyHoVc
         UNHfAKfPne5yTNm1uIcgoqjXuXZY2fK1bHejaXAHihRaHjZceEQI6r0x8zo/5F5jbB
         2hxzY3b6WWyIA==
Received: from smtpclient.apple (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
        by ci74p00im-qukt09081701.me.com (Postfix) with ESMTPSA id 225A346C00E4;
        Mon,  9 Oct 2023 07:27:33 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Corey Anderson <coreyanderson31@icloud.com>
Mime-Version: 1.0 (1.0)
Date:   Mon, 9 Oct 2023 02:27:31 -0500
Subject: Re: [PATCHSET v5] io_uring IO interface
Message-Id: <BC6926F8-2944-4D5A-B01B-6E3DD487CC41@icloud.com>
Cc:     avi@scylladb.com, hch@lst.de, jmoyer@redhat.com,
        linux-aio@kvack.org, linux-arch@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
To:     axboe@kernel.dk
X-Mailer: iPhone Mail (21B5056e)
X-Proofpoint-ORIG-GUID: wcdW0sr3olguiOG2LgzMqOkly4wbBMeA
X-Proofpoint-GUID: wcdW0sr3olguiOG2LgzMqOkly4wbBMeA
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 clxscore=1011
 spamscore=0 bulkscore=0 mlxlogscore=344 suspectscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2310090062
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Sent from Corey Anderson=E2=80=99s cell phone=20=
