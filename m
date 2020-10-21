Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766D8294F10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 16:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443626AbgJUOuv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 10:50:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60170 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2442847AbgJUOuu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 10:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603291849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ui07pSFmRprVluh7b5FPlpkbusJBG/+iyA3QcwbOIAo=;
        b=acaesCFfCJFC7qrI+qplIryST0NJaLnYiZQ3KmAMp4xPUMCWU72dPyNRMsJ58CSyMltXmw
        I0ephgUHk7RlS6jWF5ZnlnITPo/GVZEwSu7rA3M0Tb2y8k4UXi4cX6snrn3Bqi3mTrVGjI
        NKJjRGf/9Ybwc5n3TclbylmYMfsN84E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-F7SVLUDsO4iWHOZp74jeFA-1; Wed, 21 Oct 2020 10:50:46 -0400
X-MC-Unique: F7SVLUDsO4iWHOZp74jeFA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A13F110866A8;
        Wed, 21 Oct 2020 14:50:45 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-128.phx2.redhat.com [10.3.113.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B34D5C230;
        Wed, 21 Oct 2020 14:50:45 +0000 (UTC)
From:   Steve Dickson <SteveD@RedHat.com>
Subject: ANNOUNCE: nfs-utils-2.5.2 released.
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Message-ID: <51e19f54-9635-1037-50e7-96913988932a@RedHat.com>
Date:   Wed, 21 Oct 2020 10:50:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

Nothing too big in the release... More of a maintenance release than anything.
A couple memory leaks, a lot of clean up, as well as a number of bug fixes.  

The tarballs can be found in
  https://www.kernel.org/pub/linux/utils/nfs-utils/2.5.2/
or
  http://sourceforge.net/projects/nfs/files/nfs-utils/2.5.2

The change log is in
   https://www.kernel.org/pub/linux/utils/nfs-utils/2.5.2/2.5.2-Changelog
or
   http://sourceforge.net/projects/nfs/files/nfs-utils/2.5.2/

The git tree is at:
   git://linux-nfs.org/~steved/nfs-utils

Please send comments/bugs to linux-nfs@vger.kernel.org

steved.

