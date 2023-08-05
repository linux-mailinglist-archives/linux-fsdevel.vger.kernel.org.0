Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1F2770EFD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Aug 2023 11:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjHEJPX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Aug 2023 05:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjHEJPV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Aug 2023 05:15:21 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E06469C
        for <linux-fsdevel@vger.kernel.org>; Sat,  5 Aug 2023 02:15:20 -0700 (PDT)
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 530764422B
        for <linux-fsdevel@vger.kernel.org>; Sat,  5 Aug 2023 09:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691226917;
        bh=he5GySUoQLPsseBXBuQ2enEJ6BhDheUHRI1MVxf5QHA=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=XB5MKXGcrgnk2Ild3b2f+vYlKXY1e8xlZFKlflRYZaRWrcJIKDPzatnw8qXXhbfzZ
         h/BYP/UH9gpI2AQlwY9bpD/zeIpEkvZ/IzhA5cb74rBIPajoOn6O8Do+7PCjy+p8IA
         /lssAdaEM9g9NIfiP8eFLbzCdCe3zjFK6MDr/XGeQYwXt+KuW2xYX6BydL+ueUURp7
         pI1Z0cuSb8FHJeoYX0rq2zt0yu2jGT7LmUn34LjUw6VByGGTBZkmT7IfO1ZUcsqCnG
         70tmWV65HDVhRp2mjKEKYPfPdFMWobcjmcIyxrPOpxBSCWcKC5vwPZKln6NKqWnBK9
         jGhqyEXJL49mQ==
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-583d1d0de65so32975967b3.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Aug 2023 02:15:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691226916; x=1691831716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=he5GySUoQLPsseBXBuQ2enEJ6BhDheUHRI1MVxf5QHA=;
        b=SsZhhtmhxCQg09LCwKJuVK3UeE2pIslJy1Pov7ZTKDpCE4hIoEUJYt/iXcxRPMW3FJ
         NgWJ9tiFJa4ofmCEF4N7ehBxRnHbDwa2bK5Rrkx2BkXpLXYDpUId3yZ9XbV0jHmRYeiz
         aVw2/txzX1an7dBpA8yfacHfcX042YBdxEWhoL4uFhFVqzJQR5hOqFze0Uq4d5GlbhBh
         /B5ah1+Qu2z5HmmBpzob4ZAsQhR09gAU2uF6mmx6gUBm5+5IHXwC7U4vv6SPpibqSnO6
         BMtcw19lpE86Lbi81YWZxsixqnAXSK1ooPrLCLItUONN+fiGK+5m6k1dgpphZ5LTZs+r
         Ggaw==
X-Gm-Message-State: AOJu0YyEI5m78XZwQek3rK25eaS0UrErpP+5qH1Q/cA3Q/pHPRDj4NfR
        RgTyXT3Mebu6aWn4gMCjiSyLf69FCE2jJ3UBH2pytPSbM2xuoRPOBFOnkB7XVzTcZnwUHjEbeuP
        KRC88wHOe3k0yIlDyhW9RBKW7Asn7D+iUXJkdMpmTojLthuLE9o/92GpkF2k=
X-Received: by 2002:a81:83ca:0:b0:573:98a3:f01a with SMTP id t193-20020a8183ca000000b0057398a3f01amr4215504ywf.40.1691226916091;
        Sat, 05 Aug 2023 02:15:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHee+1iqFoxJqWj+kLXxxN2RpmZnf/98FaLShItjuySKcL3uPLKamZd5xit6ND0fHfcioL2rcy0kAVk5EJzDBc=
X-Received: by 2002:a81:83ca:0:b0:573:98a3:f01a with SMTP id
 t193-20020a8183ca000000b0057398a3f01amr4215485ywf.40.1691226915780; Sat, 05
 Aug 2023 02:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230804084858.126104-4-aleksandr.mikhalitsyn@canonical.com> <202308050925.ifGg1BUH-lkp@intel.com>
In-Reply-To: <202308050925.ifGg1BUH-lkp@intel.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Sat, 5 Aug 2023 11:15:04 +0200
Message-ID: <CAEivzxc2gHRXrmBnC339-ULP6xHMOORRVxZHjnNUmBeNs_+p8Q@mail.gmail.com>
Subject: Re: [PATCH v9 03/12] ceph: handle idmapped mounts in create_request_message()
To:     kernel test robot <lkp@intel.com>
Cc:     xiubli@redhat.com, oe-kbuild-all@lists.linux.dev,
        brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 5, 2023 at 3:56=E2=80=AFAM kernel test robot <lkp@intel.com> wr=
ote:
>
> Hi Alexander,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on ceph-client/testing]
> [cannot apply to ceph-client/for-linus brauner-vfs/vfs.all linus/master v=
fs-idmapping/for-next v6.5-rc4 next-20230804]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Mikhalit=
syn/fs-export-mnt_idmap_get-mnt_idmap_put/20230804-165330
> base:   https://github.com/ceph/ceph-client.git testing
> patch link:    https://lore.kernel.org/r/20230804084858.126104-4-aleksand=
r.mikhalitsyn%40canonical.com
> patch subject: [PATCH v9 03/12] ceph: handle idmapped mounts in create_re=
quest_message()
> config: um-randconfig-r091-20230730 (https://download.01.org/0day-ci/arch=
ive/20230805/202308050925.ifGg1BUH-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20230805/202308050925=
.ifGg1BUH-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202308050925.ifGg1BUH-lkp=
@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
> >> fs/ceph/mds_client.c:3082:35: sparse: sparse: incorrect type in assign=
ment (different base types) @@     expected restricted __le32 [usertype] st=
ruct_len @@     got unsigned long @@
>    fs/ceph/mds_client.c:3082:35: sparse:     expected restricted __le32 [=
usertype] struct_len
>    fs/ceph/mds_client.c:3082:35: sparse:     got unsigned long
>
> vim +3082 fs/ceph/mds_client.c
>
>   2927
>   2928  /*
>   2929   * called under mdsc->mutex
>   2930   */
>   2931  static struct ceph_msg *create_request_message(struct ceph_mds_se=
ssion *session,
>   2932                                                 struct ceph_mds_re=
quest *req,
>   2933                                                 bool drop_cap_rele=
ases)
>   2934  {
>   2935          int mds =3D session->s_mds;
>   2936          struct ceph_mds_client *mdsc =3D session->s_mdsc;
>   2937          struct ceph_client *cl =3D mdsc->fsc->client;
>   2938          struct ceph_msg *msg;
>   2939          struct ceph_mds_request_head_legacy *lhead;
>   2940          const char *path1 =3D NULL;
>   2941          const char *path2 =3D NULL;
>   2942          u64 ino1 =3D 0, ino2 =3D 0;
>   2943          int pathlen1 =3D 0, pathlen2 =3D 0;
>   2944          bool freepath1 =3D false, freepath2 =3D false;
>   2945          struct dentry *old_dentry =3D NULL;
>   2946          int len;
>   2947          u16 releases;
>   2948          void *p, *end;
>   2949          int ret;
>   2950          bool legacy =3D !(session->s_con.peer_features & CEPH_FEA=
TURE_FS_BTIME);
>   2951          u16 request_head_version =3D mds_supported_head_version(s=
ession);
>   2952
>   2953          ret =3D set_request_path_attr(mdsc, req->r_inode, req->r_=
dentry,
>   2954                                req->r_parent, req->r_path1, req->r=
_ino1.ino,
>   2955                                &path1, &pathlen1, &ino1, &freepath=
1,
>   2956                                test_bit(CEPH_MDS_R_PARENT_LOCKED,
>   2957                                          &req->r_req_flags));
>   2958          if (ret < 0) {
>   2959                  msg =3D ERR_PTR(ret);
>   2960                  goto out;
>   2961          }
>   2962
>   2963          /* If r_old_dentry is set, then assume that its parent is=
 locked */
>   2964          if (req->r_old_dentry &&
>   2965              !(req->r_old_dentry->d_flags & DCACHE_DISCONNECTED))
>   2966                  old_dentry =3D req->r_old_dentry;
>   2967          ret =3D set_request_path_attr(mdsc, NULL, old_dentry,
>   2968                                req->r_old_dentry_dir,
>   2969                                req->r_path2, req->r_ino2.ino,
>   2970                                &path2, &pathlen2, &ino2, &freepath=
2, true);
>   2971          if (ret < 0) {
>   2972                  msg =3D ERR_PTR(ret);
>   2973                  goto out_free1;
>   2974          }
>   2975
>   2976          req->r_altname =3D get_fscrypt_altname(req, &req->r_altna=
me_len);
>   2977          if (IS_ERR(req->r_altname)) {
>   2978                  msg =3D ERR_CAST(req->r_altname);
>   2979                  req->r_altname =3D NULL;
>   2980                  goto out_free2;
>   2981          }
>   2982
>   2983          /*
>   2984           * For old cephs without supporting the 32bit retry/fwd f=
eature
>   2985           * it will copy the raw memories directly when decoding t=
he
>   2986           * requests. While new cephs will decode the head dependi=
ng the
>   2987           * version member, so we need to make sure it will be com=
patible
>   2988           * with them both.
>   2989           */
>   2990          if (legacy)
>   2991                  len =3D sizeof(struct ceph_mds_request_head_legac=
y);
>   2992          else if (request_head_version =3D=3D 1)
>   2993                  len =3D sizeof(struct ceph_mds_request_head_old);
>   2994          else if (request_head_version =3D=3D 2)
>   2995                  len =3D offsetofend(struct ceph_mds_request_head,=
 ext_num_fwd);
>   2996          else
>   2997                  len =3D sizeof(struct ceph_mds_request_head);
>   2998
>   2999          /* filepaths */
>   3000          len +=3D 2 * (1 + sizeof(u32) + sizeof(u64));
>   3001          len +=3D pathlen1 + pathlen2;
>   3002
>   3003          /* cap releases */
>   3004          len +=3D sizeof(struct ceph_mds_request_release) *
>   3005                  (!!req->r_inode_drop + !!req->r_dentry_drop +
>   3006                   !!req->r_old_inode_drop + !!req->r_old_dentry_dr=
op);
>   3007
>   3008          if (req->r_dentry_drop)
>   3009                  len +=3D pathlen1;
>   3010          if (req->r_old_dentry_drop)
>   3011                  len +=3D pathlen2;
>   3012
>   3013          /* MClientRequest tail */
>   3014
>   3015          /* req->r_stamp */
>   3016          len +=3D sizeof(struct ceph_timespec);
>   3017
>   3018          /* gid list */
>   3019          len +=3D sizeof(u32) + (sizeof(u64) * req->r_cred->group_=
info->ngroups);
>   3020
>   3021          /* alternate name */
>   3022          len +=3D sizeof(u32) + req->r_altname_len;
>   3023
>   3024          /* fscrypt_auth */
>   3025          len +=3D sizeof(u32); // fscrypt_auth
>   3026          if (req->r_fscrypt_auth)
>   3027                  len +=3D ceph_fscrypt_auth_len(req->r_fscrypt_aut=
h);
>   3028
>   3029          /* fscrypt_file */
>   3030          len +=3D sizeof(u32);
>   3031          if (test_bit(CEPH_MDS_R_FSCRYPT_FILE, &req->r_req_flags))
>   3032                  len +=3D sizeof(__le64);
>   3033
>   3034          msg =3D ceph_msg_new2(CEPH_MSG_CLIENT_REQUEST, len, 1, GF=
P_NOFS, false);
>   3035          if (!msg) {
>   3036                  msg =3D ERR_PTR(-ENOMEM);
>   3037                  goto out_free2;
>   3038          }
>   3039
>   3040          msg->hdr.tid =3D cpu_to_le64(req->r_tid);
>   3041
>   3042          lhead =3D find_legacy_request_head(msg->front.iov_base,
>   3043                                           session->s_con.peer_feat=
ures);
>   3044
>   3045          if ((req->r_mnt_idmap !=3D &nop_mnt_idmap) &&
>   3046              !test_bit(CEPHFS_FEATURE_HAS_OWNER_UIDGID, &session->=
s_features)) {
>   3047                  pr_err_ratelimited_client(cl,
>   3048                          "idmapped mount is used and CEPHFS_FEATUR=
E_HAS_OWNER_UIDGID"
>   3049                          " is not supported by MDS. Fail request w=
ith -EIO.\n");
>   3050
>   3051                  ret =3D -EIO;
>   3052                  goto out_err;
>   3053          }
>   3054
>   3055          /*
>   3056           * The ceph_mds_request_head_legacy didn't contain a vers=
ion field, and
>   3057           * one was added when we moved the message version from 3=
->4.
>   3058           */
>   3059          if (legacy) {
>   3060                  msg->hdr.version =3D cpu_to_le16(3);
>   3061                  p =3D msg->front.iov_base + sizeof(*lhead);
>   3062          } else if (request_head_version =3D=3D 1) {
>   3063                  struct ceph_mds_request_head_old *ohead =3D msg->=
front.iov_base;
>   3064
>   3065                  msg->hdr.version =3D cpu_to_le16(4);
>   3066                  ohead->version =3D cpu_to_le16(1);
>   3067                  p =3D msg->front.iov_base + sizeof(*ohead);
>   3068          } else if (request_head_version =3D=3D 2) {
>   3069                  struct ceph_mds_request_head *nhead =3D msg->fron=
t.iov_base;
>   3070
>   3071                  msg->hdr.version =3D cpu_to_le16(6);
>   3072                  nhead->version =3D cpu_to_le16(2);
>   3073
>   3074                  p =3D msg->front.iov_base + offsetofend(struct ce=
ph_mds_request_head, ext_num_fwd);
>   3075          } else {
>   3076                  struct ceph_mds_request_head *nhead =3D msg->fron=
t.iov_base;
>   3077                  kuid_t owner_fsuid;
>   3078                  kgid_t owner_fsgid;
>   3079
>   3080                  msg->hdr.version =3D cpu_to_le16(6);
>   3081                  nhead->version =3D cpu_to_le16(CEPH_MDS_REQUEST_H=
EAD_VERSION);
> > 3082                  nhead->struct_len =3D sizeof(struct ceph_mds_requ=
est_head);

should be
nhead->struct_len =3D cpu_to_le32(sizeof(struct ceph_mds_request_head));

Fixed and pushed https://github.com/mihalicyn/linux/commits/fs.idmapped.cep=
h


>   3083
>   3084                  owner_fsuid =3D from_vfsuid(req->r_mnt_idmap, &in=
it_user_ns,
>   3085                                            VFSUIDT_INIT(req->r_cre=
d->fsuid));
>   3086                  owner_fsgid =3D from_vfsgid(req->r_mnt_idmap, &in=
it_user_ns,
>   3087                                            VFSGIDT_INIT(req->r_cre=
d->fsgid));
>   3088                  nhead->owner_uid =3D cpu_to_le32(from_kuid(&init_=
user_ns, owner_fsuid));
>   3089                  nhead->owner_gid =3D cpu_to_le32(from_kgid(&init_=
user_ns, owner_fsgid));
>   3090                  p =3D msg->front.iov_base + sizeof(*nhead);
>   3091          }
>   3092
>   3093          end =3D msg->front.iov_base + msg->front.iov_len;
>   3094
>   3095          lhead->mdsmap_epoch =3D cpu_to_le32(mdsc->mdsmap->m_epoch=
);
>   3096          lhead->op =3D cpu_to_le32(req->r_op);
>   3097          lhead->caller_uid =3D cpu_to_le32(from_kuid(&init_user_ns=
,
>   3098                                                    req->r_cred->fs=
uid));
>   3099          lhead->caller_gid =3D cpu_to_le32(from_kgid(&init_user_ns=
,
>   3100                                                    req->r_cred->fs=
gid));
>   3101          lhead->ino =3D cpu_to_le64(req->r_deleg_ino);
>   3102          lhead->args =3D req->r_args;
>   3103
>   3104          ceph_encode_filepath(&p, end, ino1, path1);
>   3105          ceph_encode_filepath(&p, end, ino2, path2);
>   3106
>   3107          /* make note of release offset, in case we need to replay=
 */
>   3108          req->r_request_release_offset =3D p - msg->front.iov_base=
;
>   3109
>   3110          /* cap releases */
>   3111          releases =3D 0;
>   3112          if (req->r_inode_drop)
>   3113                  releases +=3D ceph_encode_inode_release(&p,
>   3114                        req->r_inode ? req->r_inode : d_inode(req->=
r_dentry),
>   3115                        mds, req->r_inode_drop, req->r_inode_unless=
,
>   3116                        req->r_op =3D=3D CEPH_MDS_OP_READDIR);
>   3117          if (req->r_dentry_drop) {
>   3118                  ret =3D ceph_encode_dentry_release(&p, req->r_den=
try,
>   3119                                  req->r_parent, mds, req->r_dentry=
_drop,
>   3120                                  req->r_dentry_unless);
>   3121                  if (ret < 0)
>   3122                          goto out_err;
>   3123                  releases +=3D ret;
>   3124          }
>   3125          if (req->r_old_dentry_drop) {
>   3126                  ret =3D ceph_encode_dentry_release(&p, req->r_old=
_dentry,
>   3127                                  req->r_old_dentry_dir, mds,
>   3128                                  req->r_old_dentry_drop,
>   3129                                  req->r_old_dentry_unless);
>   3130                  if (ret < 0)
>   3131                          goto out_err;
>   3132                  releases +=3D ret;
>   3133          }
>   3134          if (req->r_old_inode_drop)
>   3135                  releases +=3D ceph_encode_inode_release(&p,
>   3136                        d_inode(req->r_old_dentry),
>   3137                        mds, req->r_old_inode_drop, req->r_old_inod=
e_unless, 0);
>   3138
>   3139          if (drop_cap_releases) {
>   3140                  releases =3D 0;
>   3141                  p =3D msg->front.iov_base + req->r_request_releas=
e_offset;
>   3142          }
>   3143
>   3144          lhead->num_releases =3D cpu_to_le16(releases);
>   3145
>   3146          encode_mclientrequest_tail(&p, req);
>   3147
>   3148          if (WARN_ON_ONCE(p > end)) {
>   3149                  ceph_msg_put(msg);
>   3150                  msg =3D ERR_PTR(-ERANGE);
>   3151                  goto out_free2;
>   3152          }
>   3153
>   3154          msg->front.iov_len =3D p - msg->front.iov_base;
>   3155          msg->hdr.front_len =3D cpu_to_le32(msg->front.iov_len);
>   3156
>   3157          if (req->r_pagelist) {
>   3158                  struct ceph_pagelist *pagelist =3D req->r_pagelis=
t;
>   3159                  ceph_msg_data_add_pagelist(msg, pagelist);
>   3160                  msg->hdr.data_len =3D cpu_to_le32(pagelist->lengt=
h);
>   3161          } else {
>   3162                  msg->hdr.data_len =3D 0;
>   3163          }
>   3164
>   3165          msg->hdr.data_off =3D cpu_to_le16(0);
>   3166
>   3167  out_free2:
>   3168          if (freepath2)
>   3169                  ceph_mdsc_free_path((char *)path2, pathlen2);
>   3170  out_free1:
>   3171          if (freepath1)
>   3172                  ceph_mdsc_free_path((char *)path1, pathlen1);
>   3173  out:
>   3174          return msg;
>   3175  out_err:
>   3176          ceph_msg_put(msg);
>   3177          msg =3D ERR_PTR(ret);
>   3178          goto out_free2;
>   3179  }
>   3180
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
