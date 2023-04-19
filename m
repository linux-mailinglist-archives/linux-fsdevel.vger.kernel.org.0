Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B224F6E766D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 11:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbjDSJgu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 05:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbjDSJgs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:36:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8298FC645
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Apr 2023 02:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681896938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=L4v7zrylHwuRp2YWTbCpqw/6xWeZNu0GBQgJfjNAz/Y=;
        b=i8sYcNnH1QjhSeZQeCu4uGX52l4j7fPlhMmmTfS2FyCALcYUQVwl0pVZqsVI5diPBnG7HG
        qYolAxo8zA6d8jxlH1QtvFzpr0zxIHZ+OUwoRD+p2FfuBkN6vAPPX72O8OWXLjMioRQkRU
        NJq4OBGOQhgjt0fLFxEglX7WsmKkMtU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-259-J12118u3OJ-DeEPOVg5lvA-1; Wed, 19 Apr 2023 05:35:37 -0400
X-MC-Unique: J12118u3OJ-DeEPOVg5lvA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D6BF91C0755E;
        Wed, 19 Apr 2023 09:35:36 +0000 (UTC)
Received: from ws.net.home (ovpn-192-7.brq.redhat.com [10.40.192.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D05C2166B33;
        Wed, 19 Apr 2023 09:35:36 +0000 (UTC)
Date:   Wed, 19 Apr 2023 11:35:34 +0200
From:   Karel Zak <kzak@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.39-rc3
Message-ID: <20230419093534.hdksjs3jp4nsbmlo@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The util-linux release v2.39-rc3 is available at
 
  http://www.kernel.org/pub/linux/utils/util-linux/v2.39
 
Feedback and bug reports, as always, are welcomed.
 
  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

