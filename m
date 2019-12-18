Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF7F12434F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 10:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfLRJda (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 04:33:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59000 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726699AbfLRJda (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 04:33:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576661609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qsh+TUwUNo3uTkaxetxWkBaEjq+A0KvMa22sY3nKCA8=;
        b=glWgZXMuwSh60BVqGCsshMe3An+Q64vuhUtE9uCv8u0GqjDB30bFr0r5jITK0LQCb7GJ59
        NY5Ajv3mjkvk9gUTQujL5dqQ01nDgn4faxJCwdYF6I8mx2gvaOxm3OoNWu6fPQIaeFaY2T
        mGmmspukeY2L63yIsdn7jYmWnR2+m8k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-4V5vpK9RNzS5YVVtG3JIuA-1; Wed, 18 Dec 2019 04:33:25 -0500
X-MC-Unique: 4V5vpK9RNzS5YVVtG3JIuA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36E44802CB0;
        Wed, 18 Dec 2019 09:33:24 +0000 (UTC)
Received: from [10.40.205.28] (ovpn-205-28.brq.redhat.com [10.40.205.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4DA8668869;
        Wed, 18 Dec 2019 09:33:22 +0000 (UTC)
Subject: Re: [PATCH v7 01/13] exfat: add in-memory and on-disk structures and
 headers
To:     =?UTF-8?B?7KCE64Ko7J6sL1MvVyBQbGF0Zm9ybSBMYWIoVkQpL1N0YWZmIEVuZ2luZWVy?=
         =?UTF-8?B?L+yCvOyEseyghOyekA==?= <namjae.jeon@samsung.com>,
        "'Enrico Weigelt, metux IT consult'" <lkml@metux.net>
References: <20191213055028.5574-2-namjae.jeon@samsung.com>
 <CGME20191216135033epcas5p3f2ec096506b1a48535ce0796fef23b9e@epcas5p3.samsung.com>
 <088a50ad-dc67-4ff6-624d-a1ac2008b420@web.de>
 <002401d5b46d$543f7ee0$fcbe7ca0$@samsung.com>
 <c6698d0c-d909-c9dc-5608-0b986d63a471@metux.net>
 <000701d5b537$5b196f80$114c4e80$@samsung.com>
Cc:     linux-kernel@vger.kernel.org, 'Christoph Hellwig' <hch@lst.de>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        'Sungjong Seo' <sj1557.seo@samsung.com>,
        =?UTF-8?Q?'Valdis_Kl=c4=93tnieks'?= <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org
From:   Maurizio Lombardi <mlombard@redhat.com>
Message-ID: <c0d9eed8-4cb6-54a5-95a0-a18aec8b70ee@redhat.com>
Date:   Wed, 18 Dec 2019 10:33:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <000701d5b537$5b196f80$114c4e80$@samsung.com>
Content-Type: text/plain; charset=utf-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

Dne 18.12.2019 v 01:09 =EC=A0=84=EB=82=A8=EC=9E=AC/S/W Platform Lab(VD)/S=
taff Engineer/=EC=82=BC=EC=84=B1=EC=A0=84=EC=9E=90 napsal(a):
> Well, I think that there is currently no proper mkfs(format), fsck(repa=
ir) tool for linux-exfat.
> I am working on it and will announce it here as soon as possible.

Are you aware that on Debian and Fedora/RHEL distros a package named exfa=
t-utils is available?
It provides an mkfs and fsck implementation for exfat filesystems.

You can find the source code here: https://github.com/relan/exfat

Maurizio

