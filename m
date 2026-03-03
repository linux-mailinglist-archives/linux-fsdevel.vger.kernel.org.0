Return-Path: <linux-fsdevel+bounces-79276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBudJGsjp2mMegAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 19:07:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCE71F4F90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 19:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 14666302B444
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 18:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2EE377EBF;
	Tue,  3 Mar 2026 18:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="dJygi75l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1966381AF5
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 18:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772561203; cv=none; b=j/DZJLqgjTI5QnuUcgec78wJ0M6UHvENwEkGXUs3LTR3NotCvUAeqVY3CoazsV8ng/gIn8AHTY3sPEq6XCQmiCvI3J7nUslV/tiCQJM53n4QmaYqVizLjeYiJfPOtxyPhyOc1+yt6IXH8ONz+FbINU/dSUijtaKUMWWjkLDXkz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772561203; c=relaxed/simple;
	bh=wOL9rqR+KJuqvZSJgLCLuEPBH7mWkyi2JrXmHl9yjAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pYlRLLhR2fvVv7z4DIZ4r9IolPlnfPezP+uOO6gO2niVas3vQe0polBsliADwcX87ainqV4I24YRXZN0a0YXH7GQWy52sgOQJoVgY5CLyY5/DdIsdnpZ1sy3TDFEgwjFcgbnL7EITg1QYWmldmgxpuFRdWDg1LsxDEvdLHvDZB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=dJygi75l; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1772561191; bh=KjlUdjsOzm6pJry5XKEK2Wx6SVd9EaVKNafYPkrR4Uc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=dJygi75lVKA43mVnaQwlBdfPAVdSis4jB5h3GrfRWjcs/eV+bjGnEl73Q1CkoLMfSAxuUxYWAgMHD/+ZMhEF8C/DvNjwgvm+IYU3QS+8vsQGMOvByOqQP7MjwgXU9nHznZlARxHB6CWUkkDiTVAq6T0ThlEqpJGZwSgJa+9GQo48tNjzsUCT7hSn96E3O6ItiyT22PKmVkcFCjTP0t6pfAE65VAnUDtzubQ0UAqSwQ6gk353h/MTAU/J5NqOQCiBWAIVfKkaZNzyYor20+PsN0xDvEqLDrQ9ywG7X0zbI1ztYyl5GKSDHETWf2rcE9rUFeZvn56NFy0s1fVLbgQkvw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1772561191; bh=uiQpYOQ/+Be/Kyo9JbtDjh7SRSLZbCKMFxcEEhPL+gi=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=rmImhLtSV9rlGseo/NbhlSTfiqxJpx4YkQXN/i+eSzm20eNReczfpaCwUQz7V4t386mMOu4OQeLSiXRvZiFw09ltUikZPDvvXvWkO+k2MMxREQzzk2+CWKN4qX2sndFqFXR+nG0cXUKMCm8b10yV0r2BPnBsXwlxMabcoBt7qjs5TpMBd0P/81eokKunTjlCxVrUhFh86xx0vosMy/2BCyeGxv00Rd+RsxYmjHwbbMrv8h0leiJ23ZOyRA1Kjn5a9GZ262ozKNmyJFrGNoVOl3XRezYLaJEvgkOq6e+NauKqsggJamHCc2At8O5VAFnIlAj2albbhQL8+v96tWUPlA==
X-YMail-OSG: 6qEKZb4VM1mOPvHn7Uky8BLhsENz.Nyl5rO4hX07ZBdzkKNvAbN93r7SwnGv8zQ
 MOEAM1TyLxpPrC_1W4HY0I4nAGeFARjLGqVnBcy4RyeSkx3QXytRBKp5ZSBujFbe9ETIVatSforn
 FSxNg1Gg1MLkmXWZ3hqwCf7mi9wgiueuIdFsohTnJsnlQHFlfO91UgUYi0f0KIOTpzE_gyo34vOd
 TNFUNAVPak16uB8d0cDxn766g4TxsxPScRVT1LDVkTyXlC77dDNWN0NUAKMW7MA0IVIW30wXFKP1
 f1QNH44tCLkGF3DdNc9QA8Gus7CxRd5RCO.6Pi3bJZKJmqmKRRQDZgF4XgnIKiUlYcb8n5jorqjp
 w0LSJrTHs8Oe5.5.OlLBFGXheiICMdcMZQTKedlBkcui5awdhNPMQ7A8pUSBaJ352UyxgEeBRgct
 Yk.pha._3m6itzIc7m6kHXmEXA_KgV1ZVYlmqhtX1fAsxmz1iIwlHjtwcdcJDknWj2Qr4W1aGLEh
 8fxu7gojbxyumw0KoUsciBvY1iRsKXAIIurtEWEYDWRokPlDxfq_aLegp7QjdsYaGbhuRi7IRGis
 wuG_4SAsiXFTAGQkDdFTeGhzXwqV7rVp0CBrHW0VOI3ethXL.io5aAswpW_pVVzRSXe5_LsOv9Pf
 vEru9Va5BfRMitItZnB0srVAMlfS9JT2jKZKnUukCSmvdMFqilxPCmJUV7Y70F67wvKIyHMch1n8
 PqEjv14nznBVJHd1bb0Sx9mcwuP.kLGam5Ee72aUeQu7eJs5Nna6PDxEf5UYlk4Q8T.ecj9BMq8V
 3XMXfgIJxOWYkmRoO6LRk4TgVcidi8wU0ZBK.QI7G4YNdbvw3TMMefWpn.YSzt7Ijlu3Qie7N7lQ
 tKkUpdShYtVFRZFoX3rn26CMSagxvLx2JWHeHr_U4ixL_nb57HwHo4XtR2NF0SigqK.OltfPfdTs
 sno.Uuupgnzpd4rp4vPtei9eY4Sb4FwJdjaf_pFLg0iGkkYvhy9ou9dvIrgmwXYjG5l7E7DyPilp
 Dcv2ybUAEE0wIS8AnrNbHUDq9fk5ezK.XVwG0ETQIzhaHgZfobl6sdO3BkyFvjSAu7sB1JNWfOw7
 9PsD4VmoQjqBNYo4S4IgvW6gTzvAOEFjY7mHdwYzSXuwbXJvv06SQ5GpUJ2fd98pbH6SiWrKcB.G
 aYuzrJCBEYWog5v5MTcwWQbao1ozyZ_4IKN7lfm.rsu_Uz8MYThse5FBbU0knS6_cAeXxT_6dDo1
 DhY8XarHMjenIoPp_EX5P259dokFnacHP3HSIGrj515pnUVXgzHa.8LTpNkqClAb9IU4SA1BIrSZ
 Z3XMlTolP6RaTAX26CKfe0S7pMfb80D29HSvdOQZr0GnGMXPDCXRs60i3sLK1eQt8SOWzOlRxKEt
 8hrd8Wce7l.empNNiwxjvbKsGqNLjNyXHgqI8ZEcayTB34NRmyyGOykjIYDjDK_qcBWmxjyEpuqr
 A4J8uH20SOGXs.QDHuQxCHYs9Ue7xaIbrzisfGInee459BUMC5NlfxokkWnBRTBZPKKWumcL6Az5
 sRa60dpLeiEpzlapdK2_8lj6ZbTb_NCTVpN1dixQqAf4OZQp5yrcYCzlJxub6LZXox0eSHM1eLbG
 P061TdlGuOyRibM_5ujixXXOoZNLevVmB23mMrQxMD2ZYdPA70.5D_i512mvXrCBQOlPvlfH7H2W
 Z8YJd8.8eYBuVmFoQI9T91UwAGJYTKbruomiVZLqpPrPz34Fln8QHi2BnR3Hn8zWdTjthyhhwRGa
 hlI52i47RQ_IaYVv7sj_F20auQjcc_m.4tCDZRQXAuO_pSXv4nVLeM1ulnVtQmAtPefBfKZ7_MFd
 cRDdtvnXo3zt9E239CUTEl9169.cyiySvJPIPrM7emX0R7Aawd4OFz6TmDFfmcYFhwTazPpROqGQ
 W.2WeJFnKonnweBXpRvaTKIz3_CeXlAh_uhpqEqy_gDayR_EiGOnw0MhlbXVQgsNyqnP.ILnmwjY
 ke3pa6UhUF2FxSf6Nc3EhgR80iEPXCa7_uMXvZfSvtEBqWwlwegOWYveHcCtSNlvZ4XCMCntwO9E
 Qwsvn6jiRhov8dlg4SJvkMCgFnmerEqV2K.4CfBGDj.7IPSLD5DdkUsuOdsENKCfsevzsvewXUua
 ePjUyCJeo_GFXhVHx1Dmm02YkpV42riaWW7SrC8Khgjhx5h0.OMnxORbPpIy.KrI8pvK03iiOo65
 KP_7ijkM8ZjTa2GvxkG.Si2zL54Eo3_xFVPaebbNtapmaJJlb4iyygGkUYzNnGKym48ssi4xkcRu
 DFw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b6543f29-25ec-4e47-a4ff-8569995f7946
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 3 Mar 2026 18:06:31 +0000
Received: by hermes--production-gq1-6dfcf9f8b-82g65 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ec3c5f6ef2538eb0ae6f07d34b315ce9;
          Tue, 03 Mar 2026 18:06:25 +0000 (UTC)
Message-ID: <e2dd87f8-663a-4630-a678-9235233fb87f@schaufler-ca.com>
Date: Tue, 3 Mar 2026 10:06:19 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 105/110] security: replace PRIino with %llu/%llx format
 strings
To: Jeff Layton <jlayton@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox
 <willy@infradead.org>, Eric Biggers <ebiggers@kernel.org>,
 "Theodore Y. Ts'o" <tytso@mit.edu>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>,
 David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.org>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Steve French <sfrench@samba.org>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Shyam Prasad N <sprasad@microsoft.com>, Bharath SM
 <bharathsm@microsoft.com>, Alexander Aring <alex.aring@gmail.com>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 David Sterba <dsterba@suse.com>, Marc Dionne <marc.dionne@auristor.com>,
 Ian Kent <raven@themaw.net>, Luis de Bethencourt <luisbg@kernel.org>,
 Salah Triki <salah.triki@gmail.com>,
 "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
 Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
 Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
 Nicolas Pitre <nico@fluxnic.net>, Tyler Hicks <code@tyhicks.com>,
 Amir Goldstein <amir73il@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Yangtao Li <frank.li@vivo.com>,
 Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
 David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>,
 Dave Kleikamp <shaggy@kernel.org>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, Mike Marshall
 <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Anders Larsen <al@alarsen.net>,
 Zhihao Cheng <chengzhihao1@huawei.com>, Damien Le Moal <dlemoal@kernel.org>,
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>,
 John Johansen <john.johansen@canonical.com>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, "Darrick J. Wong" <djwong@kernel.org>,
 Martin Schiller <ms@dev.tdt.de>, Eric Paris <eparis@redhat.com>,
 Joerg Reuter <jreuter@yaina.de>, Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Remi Denis-Courmont <courmisch@gmail.com>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Xin Long <lucien.xin@gmail.com>, Magnus Karlsson
 <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
 fsverity@lists.linux.dev, linux-mm@kvack.org, netfs@lists.linux.dev,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, linux-nilfs@vger.kernel.org,
 v9fs@lists.linux.dev, linux-afs@lists.infradead.org, autofs@vger.kernel.org,
 ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu,
 ecryptfs@vger.kernel.org, linux-mtd@lists.infradead.org,
 jfs-discussion@lists.sourceforge.net, ntfs3@lists.linux.dev,
 ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org,
 linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
 selinux@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, netdev@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-hams@vger.kernel.org,
 linux-x25@vger.kernel.org, audit@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org,
 linux-sctp@vger.kernel.org, bpf@vger.kernel.org
References: <20260302-iino-u64-v2-0-e5388800dae0@kernel.org>
 <20260302-iino-u64-v2-105-e5388800dae0@kernel.org>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20260302-iino-u64-v2-105-e5388800dae0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.25198 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Queue-Id: 7DCE71F4F90
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[schaufler-ca.com: no valid DMARC record];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-79276-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[yahoo.com:+];
	FREEMAIL_TO(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,goodmis.org,efficios.com,intel.com,infradead.org,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de,yaina.de,holtmann.org,hartkopp.net,pengutronix.de,secunet.com,gondor.apana.org.au,fomichev.me,iogearbox.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[casey@schaufler-ca.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[171];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[schaufler-ca.com:mid,schaufler-ca.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/2/2026 12:25 PM, Jeff Layton wrote:
> Now that i_ino is u64 and the PRIino format macro has been removed,
> replace all uses in security with the concrete format strings.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

For the security/smack changes:

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  security/apparmor/apparmorfs.c       |  4 ++--
>  security/integrity/integrity_audit.c |  2 +-
>  security/ipe/audit.c                 |  2 +-
>  security/lsm_audit.c                 | 10 +++++-----
>  security/selinux/hooks.c             | 10 +++++-----
>  security/smack/smack_lsm.c           | 12 ++++++------
>  6 files changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
> index be343479f80b71566be6fda90fc4e00912faad63..7b645f40e71c956f216fa6a7d69c3ecd4e2a5ff4 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -149,7 +149,7 @@ static int aafs_count;
>  
>  static int aafs_show_path(struct seq_file *seq, struct dentry *dentry)
>  {
> -	seq_printf(seq, "%s:[%" PRIino "u]", AAFS_NAME, d_inode(dentry)->i_ino);
> +	seq_printf(seq, "%s:[%llu]", AAFS_NAME, d_inode(dentry)->i_ino);
>  	return 0;
>  }
>  
> @@ -2644,7 +2644,7 @@ static int policy_readlink(struct dentry *dentry, char __user *buffer,
>  	char name[32];
>  	int res;
>  
> -	res = snprintf(name, sizeof(name), "%s:[%" PRIino "u]", AAFS_NAME,
> +	res = snprintf(name, sizeof(name), "%s:[%llu]", AAFS_NAME,
>  		       d_inode(dentry)->i_ino);
>  	if (res > 0 && res < sizeof(name))
>  		res = readlink_copy(buffer, buflen, name, strlen(name));
> diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
> index d28dac23a4e7cf651856b80ab7756d250187ccde..d8d9e5ff1cd22b091f462d1e83d28d2d6bd983e9 100644
> --- a/security/integrity/integrity_audit.c
> +++ b/security/integrity/integrity_audit.c
> @@ -62,7 +62,7 @@ void integrity_audit_message(int audit_msgno, struct inode *inode,
>  	if (inode) {
>  		audit_log_format(ab, " dev=");
>  		audit_log_untrustedstring(ab, inode->i_sb->s_id);
> -		audit_log_format(ab, " ino=%" PRIino "u", inode->i_ino);
> +		audit_log_format(ab, " ino=%llu", inode->i_ino);
>  	}
>  	audit_log_format(ab, " res=%d errno=%d", !result, errno);
>  	audit_log_end(ab);
> diff --git a/security/ipe/audit.c b/security/ipe/audit.c
> index 0de95dd4fbea15d4d913fc42e197c3120a9d24a0..93fb59fbddd60b56c0b22be2a38b809ef9e18b76 100644
> --- a/security/ipe/audit.c
> +++ b/security/ipe/audit.c
> @@ -153,7 +153,7 @@ void ipe_audit_match(const struct ipe_eval_ctx *const ctx,
>  		if (inode) {
>  			audit_log_format(ab, " dev=");
>  			audit_log_untrustedstring(ab, inode->i_sb->s_id);
> -			audit_log_format(ab, " ino=%" PRIino "u", inode->i_ino);
> +			audit_log_format(ab, " ino=%llu", inode->i_ino);
>  		} else {
>  			audit_log_format(ab, " dev=? ino=?");
>  		}
> diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> index 523f2ee116f0f928003aec30a105d6d4ecb49b0b..737f5a263a8f79416133315edf363ece3d79c722 100644
> --- a/security/lsm_audit.c
> +++ b/security/lsm_audit.c
> @@ -202,7 +202,7 @@ void audit_log_lsm_data(struct audit_buffer *ab,
>  		if (inode) {
>  			audit_log_format(ab, " dev=");
>  			audit_log_untrustedstring(ab, inode->i_sb->s_id);
> -			audit_log_format(ab, " ino=%" PRIino "u", inode->i_ino);
> +			audit_log_format(ab, " ino=%llu", inode->i_ino);
>  		}
>  		break;
>  	}
> @@ -215,7 +215,7 @@ void audit_log_lsm_data(struct audit_buffer *ab,
>  		if (inode) {
>  			audit_log_format(ab, " dev=");
>  			audit_log_untrustedstring(ab, inode->i_sb->s_id);
> -			audit_log_format(ab, " ino=%" PRIino "u", inode->i_ino);
> +			audit_log_format(ab, " ino=%llu", inode->i_ino);
>  		}
>  		break;
>  	}
> @@ -228,7 +228,7 @@ void audit_log_lsm_data(struct audit_buffer *ab,
>  		if (inode) {
>  			audit_log_format(ab, " dev=");
>  			audit_log_untrustedstring(ab, inode->i_sb->s_id);
> -			audit_log_format(ab, " ino=%" PRIino "u", inode->i_ino);
> +			audit_log_format(ab, " ino=%llu", inode->i_ino);
>  		}
>  
>  		audit_log_format(ab, " ioctlcmd=0x%hx", a->u.op->cmd);
> @@ -246,7 +246,7 @@ void audit_log_lsm_data(struct audit_buffer *ab,
>  		if (inode) {
>  			audit_log_format(ab, " dev=");
>  			audit_log_untrustedstring(ab, inode->i_sb->s_id);
> -			audit_log_format(ab, " ino=%" PRIino "u", inode->i_ino);
> +			audit_log_format(ab, " ino=%llu", inode->i_ino);
>  		}
>  		break;
>  	}
> @@ -265,7 +265,7 @@ void audit_log_lsm_data(struct audit_buffer *ab,
>  		}
>  		audit_log_format(ab, " dev=");
>  		audit_log_untrustedstring(ab, inode->i_sb->s_id);
> -		audit_log_format(ab, " ino=%" PRIino "u", inode->i_ino);
> +		audit_log_format(ab, " ino=%llu", inode->i_ino);
>  		rcu_read_unlock();
>  		break;
>  	}
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 9430f44c81447708c67ddc35c5b4254f16731b8f..8f38de4d223ea59cfea6bbe73747d7b228e0c33f 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1400,7 +1400,7 @@ static int inode_doinit_use_xattr(struct inode *inode, struct dentry *dentry,
>  	if (rc < 0) {
>  		kfree(context);
>  		if (rc != -ENODATA) {
> -			pr_warn("SELinux: %s:  getxattr returned %d for dev=%s ino=%" PRIino "u\n",
> +			pr_warn("SELinux: %s:  getxattr returned %d for dev=%s ino=%llu\n",
>  				__func__, -rc, inode->i_sb->s_id, inode->i_ino);
>  			return rc;
>  		}
> @@ -1412,13 +1412,13 @@ static int inode_doinit_use_xattr(struct inode *inode, struct dentry *dentry,
>  					     def_sid, GFP_NOFS);
>  	if (rc) {
>  		char *dev = inode->i_sb->s_id;
> -		kino_t ino = inode->i_ino;
> +		u64 ino = inode->i_ino;
>  
>  		if (rc == -EINVAL) {
> -			pr_notice_ratelimited("SELinux: inode=%" PRIino "u on dev=%s was found to have an invalid context=%s.  This indicates you may need to relabel the inode or the filesystem in question.\n",
> +			pr_notice_ratelimited("SELinux: inode=%llu on dev=%s was found to have an invalid context=%s.  This indicates you may need to relabel the inode or the filesystem in question.\n",
>  					      ino, dev, context);
>  		} else {
> -			pr_warn("SELinux: %s:  context_to_sid(%s) returned %d for dev=%s ino=%" PRIino "u\n",
> +			pr_warn("SELinux: %s:  context_to_sid(%s) returned %d for dev=%s ino=%llu\n",
>  				__func__, context, -rc, dev, ino);
>  		}
>  	}
> @@ -3477,7 +3477,7 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
>  					   &newsid);
>  	if (rc) {
>  		pr_err("SELinux:  unable to map context to SID"
> -		       "for (%s, %" PRIino "u), rc=%d\n",
> +		       "for (%s, %llu), rc=%d\n",
>  		       inode->i_sb->s_id, inode->i_ino, -rc);
>  		return;
>  	}
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 22b6bd322840c82697c38c07b19a4677e7da2598..2eb3368a3632b836df54ba8628c16f7215ddf3ea 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -182,7 +182,7 @@ static int smk_bu_inode(struct inode *inode, int mode, int rc)
>  	char acc[SMK_NUM_ACCESS_TYPE + 1];
>  
>  	if (isp->smk_flags & SMK_INODE_IMPURE)
> -		pr_info("Smack Unconfined Corruption: inode=(%s %" PRIino "u) %s\n",
> +		pr_info("Smack Unconfined Corruption: inode=(%s %llu) %s\n",
>  			inode->i_sb->s_id, inode->i_ino, current->comm);
>  
>  	if (rc <= 0)
> @@ -195,7 +195,7 @@ static int smk_bu_inode(struct inode *inode, int mode, int rc)
>  
>  	smk_bu_mode(mode, acc);
>  
> -	pr_info("Smack %s: (%s %s %s) inode=(%s %" PRIino "u) %s\n", smk_bu_mess[rc],
> +	pr_info("Smack %s: (%s %s %s) inode=(%s %llu) %s\n", smk_bu_mess[rc],
>  		tsp->smk_task->smk_known, isp->smk_inode->smk_known, acc,
>  		inode->i_sb->s_id, inode->i_ino, current->comm);
>  	return 0;
> @@ -214,7 +214,7 @@ static int smk_bu_file(struct file *file, int mode, int rc)
>  	char acc[SMK_NUM_ACCESS_TYPE + 1];
>  
>  	if (isp->smk_flags & SMK_INODE_IMPURE)
> -		pr_info("Smack Unconfined Corruption: inode=(%s %" PRIino "u) %s\n",
> +		pr_info("Smack Unconfined Corruption: inode=(%s %llu) %s\n",
>  			inode->i_sb->s_id, inode->i_ino, current->comm);
>  
>  	if (rc <= 0)
> @@ -223,7 +223,7 @@ static int smk_bu_file(struct file *file, int mode, int rc)
>  		rc = 0;
>  
>  	smk_bu_mode(mode, acc);
> -	pr_info("Smack %s: (%s %s %s) file=(%s %" PRIino "u %pD) %s\n", smk_bu_mess[rc],
> +	pr_info("Smack %s: (%s %s %s) file=(%s %llu %pD) %s\n", smk_bu_mess[rc],
>  		sskp->smk_known, smk_of_inode(inode)->smk_known, acc,
>  		inode->i_sb->s_id, inode->i_ino, file,
>  		current->comm);
> @@ -244,7 +244,7 @@ static int smk_bu_credfile(const struct cred *cred, struct file *file,
>  	char acc[SMK_NUM_ACCESS_TYPE + 1];
>  
>  	if (isp->smk_flags & SMK_INODE_IMPURE)
> -		pr_info("Smack Unconfined Corruption: inode=(%s %" PRIino "u) %s\n",
> +		pr_info("Smack Unconfined Corruption: inode=(%s %llu) %s\n",
>  			inode->i_sb->s_id, inode->i_ino, current->comm);
>  
>  	if (rc <= 0)
> @@ -253,7 +253,7 @@ static int smk_bu_credfile(const struct cred *cred, struct file *file,
>  		rc = 0;
>  
>  	smk_bu_mode(mode, acc);
> -	pr_info("Smack %s: (%s %s %s) file=(%s %" PRIino "u %pD) %s\n", smk_bu_mess[rc],
> +	pr_info("Smack %s: (%s %s %s) file=(%s %llu %pD) %s\n", smk_bu_mess[rc],
>  		sskp->smk_known, smk_of_inode(inode)->smk_known, acc,
>  		inode->i_sb->s_id, inode->i_ino, file,
>  		current->comm);
>

