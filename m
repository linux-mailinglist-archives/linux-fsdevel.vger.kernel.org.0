Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815B36BDF84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Mar 2023 04:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjCQDVH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 23:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjCQDU0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 23:20:26 -0400
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1DE6FFC6
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Mar 2023 20:19:23 -0700 (PDT)
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
        by mx0a-00364e01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32H3G3Yq024560
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Mar 2023 23:19:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=from : content-type
 : content-transfer-encoding : mime-version : subject : message-id : date :
 to; s=pps01; bh=DzDVr5CUzMslmqMue2o8etSF8lKLDPlvSKy4IHuo0vY=;
 b=jyRT2wW4hxnueIqx6TRnSyQzx5gdcQsyY+P0+zKU6jowyU9ApOQMe6Jg3Dhg+Hvj3lDa
 dN9c8TWSwcZGZBdo+WTdq23K3CAardWg786saPQY8zlRkF8qUrvvw48wU2U/sLtoUqU5
 YfNuegBvHQ2+Cmxrrv6SvDrR+Sg3ByIrBhA34sLNCxV4pfITRwjKRpclGVnUTXzARR2P
 SBpvQBAmXiwznAFTiX1aeXyq5mDdIxCB+f11eODF71qU4GzaM8UbJGP9mUiWqs+QMGV+
 gAtceZwSforHSCT7RmWMdtqBpxDWlexjRvLY8ai9XY/67z6aNAp95i5Vbhq2Zr3cLMY/ 7w== 
Received: from sendprdmail21.cc.columbia.edu (sendprdmail21.cc.columbia.edu [128.59.72.23])
        by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 3pcbmd9asj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Mar 2023 23:19:23 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by sendprdmail21.cc.columbia.edu (8.14.7/8.14.4) with ESMTP id 32H3JLfj114730
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Mar 2023 23:19:22 -0400
Received: by mail-qt1-f200.google.com with SMTP id t22-20020ac86a16000000b003bd1c0f74cfso1887221qtr.20
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Mar 2023 20:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679023161;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DzDVr5CUzMslmqMue2o8etSF8lKLDPlvSKy4IHuo0vY=;
        b=44Y3mNHJrKYqrzEloae14kp8rtTZdoVTovcuqukCxxHggy+HPB+/ueo1/PEr6CfiLU
         h675IJN8eJY2T3Er+ItsN+aPwJVXnwM7GY2d9/gEPAj74mG36b8Ex5HFZ8Hc0hmcWrnI
         9RCKYXrrAJEvloCdgFfnw1qO/L22/GGxiCwWekx6HgYbj3oYtLYvVuywqouMxHp3aMFM
         f1hBWGIEo0O0fCoTMXrTA03INY8NEiItCB67eX2/WnfUIr0eRFxliotfs/TALEgstqm8
         ft4LOF8N5QeM7SVpptAQ8wTnb3p2oZf3cX0pa2tBcNjtESsP2M0d/Z0pF+fAHXdr0I9g
         75rA==
X-Gm-Message-State: AO0yUKX3oE+ZyRjz+JhCXSoctIIYG44+BXjgpbZ5Z2Wi8SOzIkZoKFo3
        6MQszca+itjPM5/kTih1MQrK/FOKoStOJDE7sks4amlgmFrotb7HDmb4eubTGhHIoefFPHzB1Zt
        Se2we5udnwp/gWT3gxn3HXSj9KHFe3WoH+99X7LPYpg==
X-Received: by 2002:a05:6214:2303:b0:583:91b3:198a with SMTP id gc3-20020a056214230300b0058391b3198amr38609185qvb.2.1679023161521;
        Thu, 16 Mar 2023 20:19:21 -0700 (PDT)
X-Google-Smtp-Source: AK7set83BGGnD8lx76j3L09UnoHW4/bK3R82Y8iez3NKmcavA6hzMq5LXqNP2+yqLvm0a917I2FEyA==
X-Received: by 2002:a05:6214:2303:b0:583:91b3:198a with SMTP id gc3-20020a056214230300b0058391b3198amr38609172qvb.2.1679023161196;
        Thu, 16 Mar 2023 20:19:21 -0700 (PDT)
Received: from smtpclient.apple (dyn-160-39-19-37.dyn.columbia.edu. [160.39.19.37])
        by smtp.gmail.com with ESMTPSA id 137-20020a37088f000000b00745d24019dfsm812642qki.99.2023.03.16.20.19.20
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Mar 2023 20:19:20 -0700 (PDT)
From:   Ioannis Zarkadas <iz2175@columbia.edu>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: fsnotify: Question on proper use in-kernel
Message-Id: <E12A0E13-3726-4270-806B-B0586D5008D2@columbia.edu>
Date:   Thu, 16 Mar 2023 23:19:10 -0400
To:     linux-fsdevel@vger.kernel.org
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Proofpoint-GUID: IXHdfxGqm2L3L3ymkdqn1cO4CC1NLwv7
X-Proofpoint-ORIG-GUID: IXHdfxGqm2L3L3ymkdqn1cO4CC1NLwv7
X-CU-OB: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_16,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 clxscore=1015 mlxscore=0 mlxlogscore=778 malwarescore=0
 bulkscore=10 impostorscore=10 lowpriorityscore=10 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303170016
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi everyone!

I'm developing a kernel module and trying to setup a directory watch =
with fsnotify.
I mainly copied existing code paths in the kernel that I found, because =
I couldn't
find any usage documentation.
I am using Linux Kernel version 5.12.0.

My issue is the following:
- Setting up the watch works initially.
- If I remove and reinsert the kernel module, fsnotify_add_inode_mark =
fails with EEXIST.

So I must be doing something wrong. I am using the put/destroy methods =
for the mark
and the put method for the group when unloading the module.

Here is how I setup the watch:

> static struct fsnotify_group *group;
> static struct fsnotify_mark mark;
>
> static int setup_sync_dir_watch(char *sync_dir) {
>     int ret;
>     struct fsnotify_mark *old_mark;
>     struct path sync_dir_path;
>
>     pr_info("%s: Syncing extents for files under '%s'\n", MODULE_NAME,
>             sync_dir);
>
>     group =3D fsnotify_alloc_group(&nvmeof_xrp_fsnotify_ops);
>     if (IS_ERR(group)) {
>         pr_err("%s: Error allocating fsnotify group!\n", MODULE_NAME);
>         return -1;
>     }
>     ret =3D kern_path(sync_dir, LOOKUP_FOLLOW, &sync_dir_path);
>     if (ret) {
>         pr_err("%s: Error getting kernel path: %d!\n", MODULE_NAME, =
ret);
>         goto release_group;
>     }
>     fsnotify_init_mark(&mark, group);
>     mark.mask =3D FS_CREATE | FS_DELETE | FS_MODIFY |
>                                  FS_CLOSE_WRITE | FS_EVENT_ON_CHILD;
>     ret =3D fsnotify_add_inode_mark(&mark,
>                                   sync_dir_path.dentry->d_inode, 0);
>     path_put(&sync_dir_path);
>     if (ret) {
>         pr_err("%s: Error adding fsnotify mark! Error code: %d\n", =
MODULE_NAME,
>                ret);
>         goto release_mark;
>     }
>     return 0;
> release_mark:
>     fsnotify_destroy_mark(&mark, group);
>     fsnotify_put_mark(&mark);
> release_group:
>     fsnotify_put_group(group);
>     return ret;
> }

And here is how I clear it when exiting the module:

> static void __exit module_exit(void) {
>     fsnotify_destroy_mark(&mark, group);
>     fsnotify_put_mark(&mark);
>     fsnotify_put_group(group);

I also tried to find the mark and delete it, but it returns NULL even =
though
fsnotify_add_inode_mark returns EEXISTS:

> mutex_lock(&group->mark_mutex);
> old_mark =3D fsnotify_find_mark(
>     &sync_dir_path.dentry->d_inode->i_fsnotify_marks,
>     group);
> if (old_mark !=3D NULL) {
>     pr_info("%s: Found old mark, destroying it...\n", MODULE_NAME);
>     fsnotify_destroy_mark(old_mark, group);
>     fsnotify_put_mark(old_mark);
> }
> mutex_unlock(&group->mark_mutex);

Thanks in advance,
Yannis=
