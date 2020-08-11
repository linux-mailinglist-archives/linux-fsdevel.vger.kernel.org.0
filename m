Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7F4241D48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 17:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbgHKPfx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 11:35:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44619 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728685AbgHKPfx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:35:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597160151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R57cdnNBc8xvI38YHUTYIUcvLFIlnKvjbE+L0qvGz4U=;
        b=bIcLKuzcBedOO2kBhUUbxWGdcl7B0Y0BexWPbWpGvjZVr6phREvxuRkBywDifaAJ1Kusz6
        gnAalJ/CviSl+4zSmFOWl1MzXHEMIi/ulILEDpU18oH2g9O71TIajecthNwgBOJnIBXTU1
        huDyb2AZB2tnGTxwZAyJbajbWRkssCI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-c0s8zUUBMFKULvkhaGcVbA-1; Tue, 11 Aug 2020 11:35:50 -0400
X-MC-Unique: c0s8zUUBMFKULvkhaGcVbA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F87119200C1;
        Tue, 11 Aug 2020 15:35:49 +0000 (UTC)
Received: from rules.brq.redhat.com (unknown [10.40.208.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8338D6111F;
        Tue, 11 Aug 2020 15:35:39 +0000 (UTC)
From:   Vladis Dronov <vdronov@redhat.com>
To:     ap420073@gmail.com
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] debugfs: Check module state before warning in {full/open}_proxy_open()
Date:   Tue, 11 Aug 2020 17:34:28 +0200
Message-Id: <20200811153428.58901-1-vdronov@redhat.com>
In-Reply-To: <20200218043150.29447-1-ap420073@gmail.com>
References: <20200218043150.29447-1-ap420073@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This fix does not work as intended, please see:

https://lore.kernel.org/linux-fsdevel/20200811150129.53343-1-vdronov@redhat.com/T/#u

Regards,
Vladis

