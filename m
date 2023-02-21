Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B3469E531
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Feb 2023 17:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbjBUQ4c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Feb 2023 11:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbjBUQ4b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:56:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EC4C646
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Feb 2023 08:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676998546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZIxFtdWW9YvaQac4utVO14RjJXAOTRDmmiyc46FzG2A=;
        b=UwoqsCEwtAbEQ8FiIV0L9xEJzProLpPI3FCLh+KvwCSrvNwcrZla7LtwmIorcNRlNQ0qzu
        JPsE0J1Jv+hEfbaVDMENIGLbXETb/Vpr1Gdze53RdX/NoQhZJfaCwz3EH3orJ3VWA8sDYX
        vtGwEQObQZDSEh2yns/bq/FlrJKVgBM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-CimRLvF8PDqRJmwO7CWFiA-1; Tue, 21 Feb 2023 11:55:42 -0500
X-MC-Unique: CimRLvF8PDqRJmwO7CWFiA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 81920802C18;
        Tue, 21 Feb 2023 16:55:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 034521121314;
        Tue, 21 Feb 2023 16:55:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     lsf-pc@lists.linux-foundation.org
cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [LSF/MM/BPF TOPIC] Linux Security Summit cross-over?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 21 Feb 2023 16:55:41 +0000
Message-ID: <2896937.1676998541@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Since the first day of the LSS is the same as the final day of LSF and in t=
he
same venue, are there any filesystem + security subjects that would merit a
common session?

LSF/MM, May 8=E2=80=9310,  Vancouver, BC (Canada)
https://events.linuxfoundation.org/lsfmm

LSS-NA, May 10-12, Vancouver, BC (Canada)
https://events.linuxfoundation.org/linux-security-summit-north-america

David

