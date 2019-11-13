Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4426FABC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 09:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfKMIHQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 03:07:16 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:36913 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfKMIHQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 03:07:16 -0500
Received: from mail-qk1-f171.google.com ([209.85.222.171]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N3K9E-1hm9TM31rW-010OG7; Wed, 13 Nov 2019 09:07:14 +0100
Received: by mail-qk1-f171.google.com with SMTP id e2so960534qkn.5;
        Wed, 13 Nov 2019 00:07:14 -0800 (PST)
X-Gm-Message-State: APjAAAW243KPS1ttHSNpjAyRUJfbsWiMTiXGF7eIKXYJexnOBbJThUMR
        WVpOB38Judr7ThcaPV5ZxvtOqWbLn6eislwB3+I=
X-Google-Smtp-Source: APXvYqy/5+knIMq8SxgXUSdJeP+oZ4qutM2G54ElJDh+6Wmp59aE9mrihg2W3rybdtUrJ90Tgup09KKBFVP+pL9nX4A=
X-Received: by 2002:a37:44d:: with SMTP id 74mr1356520qke.3.1573632433479;
 Wed, 13 Nov 2019 00:07:13 -0800 (PST)
MIME-Version: 1.0
References: <20191108213257.3097633-1-arnd@arndb.de> <20191108213257.3097633-14-arnd@arndb.de>
 <2520E708-4636-4CA8-B953-0F46F8E7454A@dubeyko.com>
In-Reply-To: <2520E708-4636-4CA8-B953-0F46F8E7454A@dubeyko.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 13 Nov 2019 09:06:57 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1Bvdb4Xn1Aqfnxnn24HPb6FXxAAVwq8ypO31AqoR1hBw@mail.gmail.com>
Message-ID: <CAK8P3a1Bvdb4Xn1Aqfnxnn24HPb6FXxAAVwq8ypO31AqoR1hBw@mail.gmail.com>
Subject: Re: [Y2038] [PATCH 13/16] hfs/hfsplus: use 64-bit inode timestamps
To:     Viacheslav Dubeyko <slava@dubeyko.com>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        =?UTF-8?Q?Ernesto_A=2E_Fern=C3=A1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:d1yoZnx3cuZgujn6Y70WA+TE8zJ+43yzUhwPYsW72XZsslDYl3s
 SSjgsKIIXO+LXcgtxOoVpTKyzf5vPi4KV2UVECpvC6Bq/BTUqnwTkr7ZVoddv8f34WR8xv3
 ITedgdaMSvARRj2jWOc1DfEaxTzB8+mhHgu1GFkhYaavFrvDL3WiyOsrY+d6MihJ5rZB69V
 UMLekNLubKlLHPGNVks5A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lxc8dwWyuQA=:MbJBnHgVZWCtnGAwO/noXJ
 Elt+SyDlCG34LDeqKB3b9MlPQ3xVpSSGO2XOd9XHCc4nbhsHC038QtorEN5GTzi/QqPonZ0Fv
 h0ZrgN38OPtAyQLupIOg9+6rj6hb7vl5r6pK15vJ15kLV+13UcBHysZCzRiayokDp7ka93K/n
 RdWxdbxY3QP9VMG9cMiT7YZLntolGPI5gtS78I4lztNHnsbuFmNjEc0rx5rAGBa3qR7qrtRBT
 9vxmHzTTpLZ9tycUrMq8L41oKBI8AXdFZVACOr5QRAFaKXjPTc7OQZrt2JFzRdQHRAxQANHYd
 dhDAJf68BbVLkjM3F5T79XTlf9vN/TvP+yEtrpXAV+pvV7RuShIg8TsDRQOuNZqWmB+WDbkOr
 2ZjCfG7bej+sPn4m94+yoX0Sg/nTSe60YCImEX75O0eUcrMJbhwcRw4tjVzLCPX07Yp3XGlIt
 N/OW3LFLt0Xdf6gMgHOxvDb5s9h182so9M6xZEldqBoehgLcRb52COIlvPslz6pxH0xd/agl2
 Z51hBihe2edKRxsxbltOl9OfCfP2u4QY1tk73UHE6G782LI7nKhfRcc5JhuaJZUO5nj4YYK0M
 a4EtEFakwGluVkUUEMMM0wTaheTGLuEyWEy9S83C38GOqGhm7yhhFMmbXyxsqURhu944XwxUR
 PpOONHwntE4g0/krKfq0xjlEdTJS6rlr+JDoVek1YSpE63ZzXwJVHJQikruP0scD21d0OAyr2
 nXuNVgdpxIKweLOTlcWGQDsHJP1RvTaW6CQAbrCcvOWeFmez2QVeYrogRo76IRDQ6gYHjB1fF
 x4uh1lpaTDpLD/Eoh+SiPNHI1+ukesgqREUox2tIgiV1d7K8pkIPiE5sA68oMGco6Qol5k/9x
 2oTf0sWh5bsGqBrbQMbg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 13, 2019 at 7:00 AM Viacheslav Dubeyko <slava@dubeyko.com> wrote:
> > On Nov 9, 2019, at 12:32 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> >  * There are two time systems.  Both are based on seconds since
> >  * a particular time/date.
> > - *   Unix:   unsigned lil-endian since 00:00 GMT, Jan. 1, 1970
> > + *   Unix:   signed little-endian since 00:00 GMT, Jan. 1, 1970
> >  *    mac:    unsigned big-endian since 00:00 GMT, Jan. 1, 1904
> >  *
> > + * HFS implementations are highly inconsistent, this one matches the
> > + * traditional behavior of 64-bit Linux, giving the most useful
> > + * time range between 1970 and 2106, by treating any on-disk timestamp
> > + * under 2082844800U (Jan 1 1970) as a time between 2040 and 2106.
> >  */
> > -#define __hfs_u_to_mtime(sec)        cpu_to_be32(sec + 2082844800U - sys_tz.tz_minuteswest * 60)
> > -#define __hfs_m_to_utime(sec)        (be32_to_cpu(sec) - 2082844800U  + sys_tz.tz_minuteswest * 60)
>
> I believe it makes sense to introduce some constant instead of hardcoded value (2082844800U and 60).
> It will be easier to understand the code without necessity to take a look into the comments.
> What do you think?

Every other user of sys_tz.tz_minuteswest uses a plain '60', I think that one
is easy enough to understand from context. Naming the other constant
is a good idea, I've now folded the change below into my patch.

Thanks for the review!

      Arnd

8<-----
diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index 26733051ee50..f71c384064c8 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -247,22 +247,24 @@ extern void hfs_mark_mdb_dirty(struct super_block *sb);
  *
  * HFS implementations are highly inconsistent, this one matches the
  * traditional behavior of 64-bit Linux, giving the most useful
  * time range between 1970 and 2106, by treating any on-disk timestamp
- * under 2082844800U (Jan 1 1970) as a time between 2040 and 2106.
+ * under HFS_UTC_OFFSET (Jan 1 1970) as a time between 2040 and 2106.
  */
+#define HFS_UTC_OFFSET 2082844800U
+
 static inline time64_t __hfs_m_to_utime(__be32 mt)
 {
-       time64_t ut = (u32)(be32_to_cpu(mt) - 2082844800U);
+       time64_t ut = (u32)(be32_to_cpu(mt) - HFS_UTC_OFFSET);

        return ut + sys_tz.tz_minuteswest * 60;
 }

 static inline __be32 __hfs_u_to_mtime(time64_t ut)
 {
        ut -= sys_tz.tz_minuteswest * 60;

-       return cpu_to_be32(lower_32_bits(ut) + 2082844800U);
+       return cpu_to_be32(lower_32_bits(ut) + HFS_UTC_OFFSET);
 }
 #define HFS_I(inode)   (container_of(inode, struct hfs_inode_info, vfs_inode))
 #define HFS_SB(sb)     ((struct hfs_sb_info *)(sb)->s_fs_info)

diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 22d0a22c41a3..3b03fff68543 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -538,20 +538,22 @@ int hfsplus_read_wrapper(struct super_block *sb);
  *
  * HFS+ implementations are highly inconsistent, this one matches the
  * traditional behavior of 64-bit Linux, giving the most useful
  * time range between 1970 and 2106, by treating any on-disk timestamp
- * under 2082844800U (Jan 1 1970) as a time between 2040 and 2106.
+ * under HFSPLUS_UTC_OFFSET (Jan 1 1970) as a time between 2040 and 2106.
  */
+#define HFSPLUS_UTC_OFFSET 2082844800U
+
 static inline time64_t __hfsp_mt2ut(__be32 mt)
 {
-       time64_t ut = (u32)(be32_to_cpu(mt) - 2082844800U);
+       time64_t ut = (u32)(be32_to_cpu(mt) - HFSPLUS_UTC_OFFSET);

        return ut;
 }

 static inline __be32 __hfsp_ut2mt(time64_t ut)
 {
-       return cpu_to_be32(lower_32_bits(ut) + 2082844800U);
+       return cpu_to_be32(lower_32_bits(ut) + HFSPLUS_UTC_OFFSET);
 }

 /* compatibility */
 #define hfsp_mt2ut(t)          (struct timespec64){ .tv_sec = __hfsp_mt2ut(t) }
