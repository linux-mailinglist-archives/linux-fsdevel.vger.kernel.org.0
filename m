Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D271CFCF1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 20:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbgELSQT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 14:16:19 -0400
Received: from mailrelay115.isp.belgacom.be ([195.238.20.142]:26460 "EHLO
        mailrelay115.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725554AbgELSQS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 14:16:18 -0400
IronPort-SDR: BGohTkaPLpFZSU2hnV6Eu32j2LQv9CJn0mu5Q3KYxQSEJwry5Zpd2oxg7oM/UM/olh0gHHx1FK
 uhnHibd2THPgCtIVPvAbou0Knn/GuXNwV8NV+ekmlWY7PgNRhqGkGA7/S4L3tPuYCtMK3mKZ5e
 VBY4m1Xe1DIq28cQOu57CgFXFS1kORl/AS0odyNmfJEcSnwuunHI13RzhWL2Sp1t5oAKYZ/oxG
 ZUlu6N5kKaqs/Ae9zPxj97R7npPzg8TVcOFvf01bWm+mAnHyAxFJUzvMLU+3qz+yddbSk69Xgn
 i54=
X-Belgacom-Dynamic: yes
IronPort-PHdr: =?us-ascii?q?9a23=3AKwXe5RXgc2rBBTinUjEendD5VG3V8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbRCPt8tkgFKBZ4jH8fUM07OQ7/m9Hz1aqs/Y4DgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrrQjdrM0bjZVtJqos1x?=
 =?us-ascii?q?fEoWZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+2zRl8d+jr9UoAi5qhJ/3YDafY+bOvl5cKzSct0XXn?=
 =?us-ascii?q?ZNU8VLWiBdGI6wc5cDAuwcNuhYtYn9oF4OoAO+Cwa2H+zvyyVHhnnr1qM6ye?=
 =?us-ascii?q?QuDxzJ0xI6H9IPrHvUr8j+OaAcUe+v16bIwy7Ob+hV2Tb97ojHbAwhreuXUr?=
 =?us-ascii?q?1uaMfcz1QkGAzZgFuKs4PlIy+V2foXs2id9+duW+GihmonpQxwojWj2MkhhI?=
 =?us-ascii?q?nUi44J11zI6SR0zok6K9ClRkN2f8OpHZtSuiyEOIV6Xs0sTW5stSg6yrMKp5?=
 =?us-ascii?q?q2cS4Xw5ok3x7Sc/iKf5WS7h7+V+udPy10iG9kdb+/nRq+7Emtx+vhXceuyl?=
 =?us-ascii?q?lKtDBKktzUu3AI0Bzc99aIR+Nm/kekxTaPzwfT6vxYIUwslarUNZohwrkom5?=
 =?us-ascii?q?UIsETDESD2mFjtjK+NcUUk/vWo6//9brXmoZ+cMpF7hhn/MqQohMO/Hfw1Pw?=
 =?us-ascii?q?wTU2SB5Oix16Pv8VfkTLhLjvA6iLTVvZHCKcQevKG5AgtV0og56xa4CjeryN?=
 =?us-ascii?q?oYkmMcI1JLYx+HlIvpOlHIIP/mEfezmU+jnylzy/DcIrLhGonNLmTEkLr5f7?=
 =?us-ascii?q?Zy8VJTyAkowNBE+pJUEa8OLOjvVU7wrNbYFAM2MxSow+b7D9VwzpkRWWeOAq?=
 =?us-ascii?q?+DMq7fv16I5uY0LumDYY8aojf9K/w/6/Hyin85nEcXfbO10psPdHC4AvNmLl?=
 =?us-ascii?q?2dYXrthNcBDGgLshMwTOzxlVKNTyBTaGi2X68n+DE7B5ypDZ3ZSoCunrOBxi?=
 =?us-ascii?q?G7EYNSZmxcDVCMC3jofZ2eW/gQcCKSPtNhkjscWLivUYAuzh+uuRThy7pkLu?=
 =?us-ascii?q?vU/DMXtY752Ndu+eKA3S01oD59BMe1yHyWQid/jCdATjo3xv8koEhVxVKK0K?=
 =?us-ascii?q?w+iPtdRvJJ4PYcfA4wNJfah8JgBtz/QAPKfZ/dRl+sTP29AiA3Q853ydJYMB?=
 =?us-ascii?q?U1IMmrkh2Wh3niOLQSjbHeXJE=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2CuBQAE57pe/xCltltmglCCKoFkEo1?=
 =?us-ascii?q?RhXyMGI9dgXsLAQEBAQEBAQEBNAECBAEBhDoKggQnNQgOAgMBAQEDAgUBAQY?=
 =?us-ascii?q?BAQEBAQEEBAFsBAEBBwoCAYROIQEDAQEFCgFDgjsig0ILASMjT3CDOIJYKbE?=
 =?us-ascii?q?9M4VRg1eBQIE4h12FAYFBP4RfikIEsmuCVIJxlSsMHZ06kB2fJgI1gVZNIBi?=
 =?us-ascii?q?DJU8YDZ8KQmcCBggBAQMJVwEiAY4IAQE?=
X-IPAS-Result: =?us-ascii?q?A2CuBQAE57pe/xCltltmglCCKoFkEo1RhXyMGI9dgXsLA?=
 =?us-ascii?q?QEBAQEBAQEBNAECBAEBhDoKggQnNQgOAgMBAQEDAgUBAQYBAQEBAQEEBAFsB?=
 =?us-ascii?q?AEBBwoCAYROIQEDAQEFCgFDgjsig0ILASMjT3CDOIJYKbE9M4VRg1eBQIE4h?=
 =?us-ascii?q?12FAYFBP4RfikIEsmuCVIJxlSsMHZ06kB2fJgI1gVZNIBiDJU8YDZ8KQmcCB?=
 =?us-ascii?q?ggBAQMJVwEiAY4IAQE?=
Received: from 16.165-182-91.adsl-dyn.isp.belgacom.be (HELO biggussolus.home) ([91.182.165.16])
  by relay.skynet.be with ESMTP; 12 May 2020 20:16:15 +0200
From:   Fabian Frederick <fabf@skynet.be>
To:     jack@suse.cz, amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, Fabian Frederick <fabf@skynet.be>
Subject: [PATCH V2 0/6 linux-next] fs/notify: cleanup
Date:   Tue, 12 May 2020 20:16:08 +0200
Message-Id: <20200512181608.405682-1-fabf@skynet.be>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This small patchset does some cleanup in fs/notify branch
especially in fanotify.

V2:
Apply Amir Goldstein suggestions:
-Remove patch 2, 7 and 9
-Patch "fanotify: don't write with zero size" ->
"fanotify: don't write with size under sizeof(response)"

Fabian Frederick (6):
  fanotify: prefix should_merge()
  notify: explicit shutdown initialization
  notify: add mutex destroy
  fanotify: remove reference to fill_event_metadata()
  fsnotify/fdinfo: remove proc_fs.h inclusion
  fanotify: don't write with size under sizeof(response)

 fs/notify/fanotify/fanotify.c      | 4 ++--
 fs/notify/fanotify/fanotify_user.c | 8 +++++---
 fs/notify/fdinfo.c                 | 1 -
 fs/notify/group.c                  | 2 ++
 4 files changed, 9 insertions(+), 6 deletions(-)

-- 
2.26.2

