Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40AE06D6198
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 14:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbjDDMvb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 08:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234596AbjDDMva (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:51:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BE640EF
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Apr 2023 05:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680612641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=fYg6UHJnGNa3r4nOIjucv7D4OMd5PduN9PZmiAqJNcA=;
        b=OVda6trcsYvOWYVSkF/q2gbDqylllAaSHhRt084mCvnxgnYNcFqYCHlveN4Tw+Ez7nH8p4
        dxGD85hSC/aT//cawAOxOmVbdXCff+zir0p8BpO76CxY20tTWou0oYaJW+5myKARyfLB9K
        JcKmcD+0EInb2sGU9yiI6f1vbVUx8EU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-18-Yx7G_4h6Pmydi9Vn4uRM5A-1; Tue, 04 Apr 2023 08:50:37 -0400
X-MC-Unique: Yx7G_4h6Pmydi9Vn4uRM5A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD4CF3C0D85B;
        Tue,  4 Apr 2023 12:50:36 +0000 (UTC)
Received: from ws.net.home (ovpn-192-2.brq.redhat.com [10.40.192.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 416AA40C6EC4;
        Tue,  4 Apr 2023 12:50:36 +0000 (UTC)
Date:   Tue, 4 Apr 2023 14:50:34 +0200
From:   Karel Zak <kzak@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.39-rc2
Message-ID: <20230404125034.vd5gypujnprzwful@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


The util-linux release v2.39-rc2 is available at
 
  http://www.kernel.org/pub/linux/utils/util-linux/v2.39
 
Feedback and bug reports, as always, are welcomed.
 
  Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

